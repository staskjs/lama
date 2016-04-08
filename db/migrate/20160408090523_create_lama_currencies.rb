class CreateLamaCurrencies < ActiveRecord::Migration
  def change
    create_table :lama_currencies do |t|
      t.string :name
      t.string :numcode
      t.boolean :base
      t.integer :created_user_id
      t.integer :updated_user_id

      t.timestamps null: false
    end
  end
end
