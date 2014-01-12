class Community < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  has_many :community_users
  has_many :users, through: :community_users
  has_many :subcommunities, foreign_key: 'community_id', dependent: :destroy
  has_many :communities, through: :subcommunities, source: :subcommunity

  def parent
    Community.find(parent_id)
  end

  def parents
  	Community.joins(:subcommunities).where(subcommunities: { subcommunity_id: id })
  end

  def state
    parents.where(type: "State")
  end

  def country
    parents.where(type: "Country")
  end

  def has_subcommunities?
    self.communities.present?
  end

  def groups
  	self.communities.where(type: "Group")
  end
end
