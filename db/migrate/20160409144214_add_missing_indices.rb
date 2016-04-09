class AddMissingIndices < ActiveRecord::Migration
  def change
    add_index :lama_product_sections, :product_id
    add_index :lama_product_sections, :section_id

    add_index :lama_prices, :currency_id
    add_index :lama_prices, :price_type_id
    add_index :lama_prices, :product_id
    add_index :lama_prices, :created_user_id
    add_index :lama_prices, :updated_user_id

    add_index :lama_price_types, :created_user_id
    add_index :lama_price_types, :updated_user_id

    add_index :lama_currencies, :created_user_id
    add_index :lama_currencies, :updated_user_id
  end
end
