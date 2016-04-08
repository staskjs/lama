class CreateLamaPrices < ActiveRecord::Migration
  def change
    create_table :lama_prices do |t|
      t.integer :product_id
      t.integer :price_type_id
      t.integer :currency_id
      t.float :price
      t.integer :created_user_id
      t.integer :updated_user_id

      t.timestamps null: false
    end
  end
end
