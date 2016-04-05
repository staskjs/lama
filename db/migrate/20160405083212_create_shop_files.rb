class CreateShopFiles < ActiveRecord::Migration
  def change
    create_table :shop_files do |t|
      t.string :name
      t.string :path
      t.text :description
      t.integer :created_user_id
      t.integer :updated_user_id
      t.string :external_id

      t.timestamps null: false
    end
  end
end
