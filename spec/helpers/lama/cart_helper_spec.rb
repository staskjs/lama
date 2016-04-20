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
      describe 'user is not signed in' do
        before :each do
          allow(helper).to receive(:user_signed_in?).and_return(false)
        end

        it 'cannot add non existing product to cart' do
          product = nil
          expect { helper.add_product_to_cart(product) }.to raise_error I18n.t 'lama.cart.add_not_existing_product'
          product = build(:lama_product)
          expect { helper.add_product_to_cart(product) }.to raise_error I18n.t 'lama.cart.add_not_existing_product'
        end

        it 'adds product to cart' do
          product = create(:lama_product)
          helper.add_product_to_cart(product)
          expect(helper.cart.length).to eq 1
          expect(helper.cart.first.quantity).to eq 1
          expect(helper.cart.first.product).to eq product
        end

        it 'adds same product to cart increasing quantity' do
          product = create(:lama_product)
          helper.add_product_to_cart(product)
          expect(helper.cart.length).to eq 1
          expect(helper.cart.first.quantity).to eq 1
          expect(helper.cart.first.product).to eq product

          helper.add_product_to_cart(product)
          expect(helper.cart.length).to eq 1
          expect(helper.cart.first.quantity).to eq 2
        end

        it 'adds different products to cart' do
          product1 = create(:lama_product)
          product2 = create(:lama_product)
          helper.add_product_to_cart(product1)
          helper.add_product_to_cart(product2)

          expect(helper.cart.length).to eql 2
          expect(helper.cart.first.quantity).to eq 1
          expect(helper.cart.second.quantity).to eq 1
        end
      end

      describe 'user is signed in' do
        before :each do
          @user = create(:lama_user)
          allow(helper).to receive(:user_signed_in?).and_return(true)
          allow(helper).to receive(:current_user).and_return(@user)
        end

        it 'adds product to cart' do
          product = create(:lama_product)
          helper.add_product_to_cart(product)
          expect(helper.cart.length).to eq 1
          expect(helper.cart.first.quantity).to eq 1
          expect(helper.cart.first.product).to eq product
          expect(helper.current_user.cart_user_products).to eq helper.cart
        end

        it 'adds same product to cart increasing quantity' do
          product = create(:lama_product)
          helper.add_product_to_cart(product)
          expect(helper.cart.length).to eq 1
          expect(helper.cart.first.quantity).to eq 1
          expect(helper.cart.first.product).to eq product

          helper.add_product_to_cart(product)
          helper.current_user.cart_user_products.reload
          expect(helper.cart.length).to eq 1
          expect(helper.cart.first.product).to eq product
          expect(helper.cart.first.quantity).to eq 2
        end

        it 'adds different products to cart' do
          product1 = create(:lama_product)
          product2 = create(:lama_product)
          helper.add_product_to_cart(product1)
          helper.add_product_to_cart(product2)
          helper.current_user.cart_user_products.reload

          expect(helper.cart.length).to eql 2
          expect(helper.cart.first.quantity).to eq 1
          expect(helper.cart.second.quantity).to eq 1
        end
      end

      describe 'shadow user is signed in' do
        before :each do
          @user = create(:lama_shadowed_user)
          allow(helper).to receive(:shadow_signed_in?).and_return(true)
          allow(helper).to receive(:current_shadow_user).and_return(@user)
          allow(helper).to receive(:user_signed_in?).and_return(false)
          allow(helper).to receive(:current_user).and_return(nil)
        end
      end
    end
  end
end
