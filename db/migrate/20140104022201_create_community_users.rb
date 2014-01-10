class CreateCommunityUsers < ActiveRecord::Migration
  def change
    create_table :community_users do |t|
      t.references :community, null: false, index: true
      t.references :user, null: false, index: true
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
