class CreateLamaPriceTypes < ActiveRecord::Migration
  def change
    create_table :lama_price_types do |t|
      t.string :name
      t.boolean :base
      t.integer :created_user_id
      t.integer :updated_user_id
      t.string :external_id

      t.timestamps null: false
    end
  end
end
