require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CartHelper. For example:
#
# describe CartHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
module Lama
  module Controllers
    describe CartHelper, type: :helper do
      it 'cannot add non existing product to cart' do
        product = nil
        expect { helper.add_product_to_cart(product) }.to raise_error 'Cannot save non-existing product'
        product = build(:lama_product)
        expect { helper.add_product_to_cart(product) }.to raise_error 'Cannot save non-existing product'
      end

      it 'can add existing product to cart' do
        product = create(:lama_product)
        helper.add_product_to_cart(product)
        expect(helper.cart.length).to eq 1
        expect(helper.cart.first.quantity).to eq 1
        expect(helper.cart.first.product).to eq product
      end

      it 'can add same product to cart' do
        product = create(:lama_product)
        helper.add_product_to_cart(product)
        expect(helper.cart.length).to eq 1
        expect(helper.cart.first.quantity).to eq 1
        expect(helper.cart.first.product).to eq product

        helper.add_product_to_cart(product)
        expect(helper.cart.length).to eq 1
        expect(helper.cart.first.quantity).to eq 2
      end
    end
  end
end
