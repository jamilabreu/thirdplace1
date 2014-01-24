class CommunitiesController < ApplicationController
  [Gender, Standing, Degree, Field, Interest, School, Culture, Company, City, Country, Orientation, Profession, Relationship, Religion ] if Rails.env.development?

  respond_to :json
  before_action :load_community, only: [:people, :news, :groups]

  def index
    @communities = School.all
  end

  def people
    # Randomness
    params[:seed] ||= Random.new_seed
    srand params[:seed].to_i

    # Users
    community_ids = [@community.id.to_s].concat(params[:f] || [])
    users = User.joins(:communities).where(communities: { id: community_ids })
    users = users.select("users.*, count(distinct(communities.id))").group("users.id").having("count(distinct(communities.id)) = (?)", community_ids.length) if params[:f]
    @users = Kaminari.paginate_array(users.shuffle).page(params[:page]).per(12)

    # Filters
    communities = Community.joins(:users).where(users: { id: users.map(&:id) }).uniq.order(:name)
    @subclass_names = Community.subclasses.map(&:name)
    @subclass_names.each do |name|
      instance_variable_set("@#{name}_filters", communities.where(type: name).where.not(id: @community))
    end
  end

  def news
    @posts = Post.all
  end

  def groups
    @groups = @community.groups
  end

  def search
    model = params[:type].present? ? params[:type].titleize.constantize : Community
    if params[:id].present?
      id = JSON.parse(params[:id].gsub(/([a-z]+)/,'"\1"'))
      @community = model.find(id)
    elsif params[:q].present?
      @community = model.where("name ILIKE (?)", "%#{params[:q]}%").order(:name)
    else
      @community = model.order(:name)
    end
    respond_with @community, only: [:id, :name, :country_name, :country_code], callback: params[:callback]
  end

  private
  def load_community
    @community = Community.friendly.find(params[:id])
  end
end