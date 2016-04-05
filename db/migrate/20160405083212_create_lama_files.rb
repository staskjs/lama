class CreateLamaFiles < ActiveRecord::Migration
  def change
    create_table :lama_files do |t|
      t.string :name
      t.string :path
      t.text :description
      t.integer :created_user_id
      t.integer :updated_user_id
      t.string :external_id

      t.timestamps null: false
    end

    add_index :lama_files, :created_user_id
    add_index :lama_files, :updated_user_id
  end
end
