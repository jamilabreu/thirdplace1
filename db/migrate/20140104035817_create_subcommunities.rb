class CreateSubcommunities < ActiveRecord::Migration
  def change
    create_table :subcommunities do |t|
      t.references :community, null: false, index: true
      t.integer :subcommunity_id, null: false, index: true

      t.timestamps
    end
  end
end
