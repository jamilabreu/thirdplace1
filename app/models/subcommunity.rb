class Subcommunity < ActiveRecord::Base
  belongs_to :community
  belongs_to :subcommunity, class_name: 'Community', foreign_key: 'subcommunity_id'
end
