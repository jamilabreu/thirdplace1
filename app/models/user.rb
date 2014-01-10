class User < ActiveRecord::Base
  # Include default devise modules. Others available are: :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  mount_uploader :image, ImageUploader

  geocoded_by :address do |user, results|
    if geo = results.first
      if city = City.near(geo.coordinates, 50).first
        user.communities << city unless user.communities.include?(city)
      end
    end
  end
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  has_many :community_users
  has_many :communities, through: :community_users

  community_types = %W[ City Company Country Culture Degree Field Gender Interest Orientation Profession Relationship Religion School Standing ]
  community_types.each do |community_type|
    has_many community_type.downcase.pluralize.to_sym, through: :community_users, class_name: community_type, source: :community
  end

  community_types.each do |community_type|
    define_method "#{community_type.downcase}_ids=" do |ids|
      self.send("#{community_type.downcase.pluralize}".to_sym).clear
      array = ids.split(",").map {|value| value.is_a?(Array) ? value.reject(&:blank?) : value unless value.include?("[") || value.include?("]") }.flatten.compact
      array.map do |community_id|
        community = Community.find(community_id)
        communities << community unless self.communities.include?(community)
      end
    end
  end

  def name=(string)
    name = string.split(" ", 2)
    write_attribute :name, string
    write_attribute :first_name, name.first
    write_attribute :last_name, name.last if name.length > 1
  end

  def self.from_linkedin_omniauth(auth, geo, signed_in_resource=nil)
    where(auth.slice(:provider, :uid)).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.nickname = auth.info.nickname
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.address = geo.address if geo.address.present? && geo.address != "Reserved"
      user.location = auth.info.location
      user.description = auth.info.description
      user.remote_image_url = auth.info.image
      user.phone = auth.info.phone
      user.headline = auth.info.headline
      user.industry = auth.info.industry
      user.linkedin_url = auth.info.urls.public_profile
      user.linkedin_image = auth.info.image
      user.linkedin_token = auth.credentials.token
      user.linkedin_secret = auth.credentials.secret
      user.password = Devise.friendly_token[0,20]
    end
  end

  def linkedin_client
    client = LinkedIn::Client.new(ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'])
    client.authorize_from_access(linkedin_token, linkedin_secret)
    client
  end

  def update_linkedin_image
    client = self.linkedin_client
    profile = client.profile fields: ["picture-urls::(original)"]
    self.remote_image_url = profile.picture_urls.all.first
  rescue
  end
end
