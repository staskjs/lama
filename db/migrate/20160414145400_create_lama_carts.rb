class CreateLamaCarts < ActiveRecord::Migration
  def change
    create_table :lama_carts do |t|
      t.integer :user_id
      t.integer :order_id
      t.integer :product_id
      t.integer :product_price_id
      t.float :price, default: 0
      t.integer :currency_id
      t.string :name
      t.integer :quantity, default: 1
      t.float :discount_price, default: 0

      t.timestamps null: false
    end
  end
end
