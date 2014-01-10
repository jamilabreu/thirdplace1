class CommunityUser < ActiveRecord::Base
  belongs_to :community
  belongs_to :user

  validates :community_id, uniqueness: {scope: :user_id}
end
