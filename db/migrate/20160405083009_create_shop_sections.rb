class CreateShopSections < ActiveRecord::Migration
  def change
    create_table :shop_sections do |t|
      t.string :name
      t.string :code
      t.integer :sort
      t.boolean :active
      t.datetime :active_from
      t.datetime :active_to
      t.text :preview_text
      t.integer :preview_picture_file_id
      t.text :detail_text
      t.integer :detail_picture_file_id
      t.string :meta_title
      t.string :meta_keywords
      t.text :meta_description
      t.integer :section_id
      t.integer :created_user_id
      t.integer :updated_user_id
      t.string :external_id

      t.timestamps null: false
    end
  end
end
