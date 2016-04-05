class CreateLamaSections < ActiveRecord::Migration
  def change
    create_table :lama_sections do |t|
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

    add_index :lama_sections, :preview_picture_file_id
    add_index :lama_sections, :detail_picture_file_id
    add_index :lama_sections, :section_id
    add_index :lama_sections, :created_user_id
    add_index :lama_sections, :updated_user_id
  end
end
