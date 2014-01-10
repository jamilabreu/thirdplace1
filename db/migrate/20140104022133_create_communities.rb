class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.string :filter_name
      t.string :member_name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :country_name
      t.string :country_code
      t.string :slug, null: false
      t.boolean :verified, default: false
      t.boolean :public, default: false
      t.integer :linkedin_id
      t.string :type

      t.timestamps
    end
  end
end
