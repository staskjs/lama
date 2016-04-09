require 'rails_helper'

#
module Lama
  describe Product, type: :model do
    it 'has no prices with same currency and price type' do
      currency = create(:lama_currency)
      price_type = create(:lama_price_type)

      product = build(:lama_product)
      price1 = build(:lama_price, currency: currency, price_type: price_type)
      price2 = build(:lama_price, currency: currency, price_type: price_type)

      product.prices << price1
      product.prices << price2

      expect(product.save).to eq false
      expect(product.errors).to have(1).errors_on(:prices)

      product.prices = [price1]
      product.save

      expect(product.prices.length).to eq(1)
      expect(product.prices.first.price).to eq price1.price

      product.prices << price2

      expect(product.save).to eq false
      expect(product.errors).to have(1).errors_on(:prices)
    end
  end
end
