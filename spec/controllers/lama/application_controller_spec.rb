require 'rails_helper'

module Lama
  describe ApplicationController, type: :controller do
    routes { Lama::Engine.routes }
    render_views

    describe 'helpers' do
      describe 'shadowed users' do
        it 'can sign in' do
          allow(subject).to receive(:user_signed_in?).and_return(false)
          expect(subject.shadow_signed_in?).to eq false

          user = create(:lama_shadowed_user)
          subject.shadow_sign_in user

          expect(subject.shadow_signed_in?).to eq true
          expect(subject.current_shadow_user).to eq user
        end

        it 'cannot sign in if normal user is already signed in' do
          allow(subject).to receive(:user_signed_in?).and_return(true)
          user = create(:lama_user)
          expect { subject.shadow_sign_in user }.to raise_error I18n.t 'lama.shadow_user.user_already_signed_in'
        end

        it 'cannot sign in not shadowed user' do
          allow(subject).to receive(:user_signed_in?).and_return(false)
          user = create(:lama_user)
          expect { subject.shadow_sign_in user }.to raise_error I18n.t 'lama.shadow_user.cannot_sign_in'
        end
      end

      describe 'cart' do
        describe 'user is not signed in' do
          before :each do
            allow(subject).to receive(:user_signed_in?).and_return(false)
          end

          it 'cannot add non existing product to cart' do
            product = nil
            expect { subject.add_product_to_cart(product) }.to raise_error I18n.t 'lama.cart.add_not_existing_product'
            product = build(:lama_product)
            expect { subject.add_product_to_cart(product) }.to raise_error I18n.t 'lama.cart.add_not_existing_product'
          end

          it 'adds product to cart' do
            product = create(:lama_product)
            subject.add_product_to_cart(product)
            expect(subject.cart.length).to eq 1
            expect(subject.cart.first.quantity).to eq 1
            expect(subject.cart.first.product).to eq product
          end

          it 'adds same product to cart increasing quantity' do
            product = create(:lama_product)
            subject.add_product_to_cart(product)
            expect(subject.cart.length).to eq 1
            expect(subject.cart.first.quantity).to eq 1
            expect(subject.cart.first.product).to eq product

            subject.add_product_to_cart(product)
            expect(subject.cart.length).to eq 1
            expect(subject.cart.first.quantity).to eq 2
          end

          it 'adds different products to cart' do
            product1 = create(:lama_product)
            product2 = create(:lama_product)
            subject.add_product_to_cart(product1)
            subject.add_product_to_cart(product2)

            expect(subject.cart.length).to eql 2
            expect(subject.cart.first.quantity).to eq 1
            expect(subject.cart.second.quantity).to eq 1
          end
        end

        describe 'user is signed in' do
          before :each do
            @user = create(:lama_user)
            allow(subject).to receive(:user_signed_in?).and_return(true)
            allow(subject).to receive(:current_user).and_return(@user)
          end

          it 'adds product to cart' do
            product = create(:lama_product)
            subject.add_product_to_cart(product)
            expect(subject.cart.length).to eq 1
            expect(subject.cart.first.quantity).to eq 1
            expect(subject.cart.first.product).to eq product
            expect(subject.current_user.cart_user_products).to eq subject.cart
          end

          it 'adds same product to cart increasing quantity' do
            product = create(:lama_product)
            subject.add_product_to_cart(product)
            expect(subject.cart.length).to eq 1
            expect(subject.cart.first.quantity).to eq 1
            expect(subject.cart.first.product).to eq product

            subject.add_product_to_cart(product)
            subject.current_user.cart_user_products.reload
            expect(subject.cart.length).to eq 1
            expect(subject.cart.first.product).to eq product
            expect(subject.cart.first.quantity).to eq 2
          end

          it 'adds different products to cart' do
            product1 = create(:lama_product)
            product2 = create(:lama_product)
            subject.add_product_to_cart(product1)
            subject.add_product_to_cart(product2)
            subject.current_user.cart_user_products.reload

            expect(subject.cart.length).to eql 2
            expect(subject.cart.first.quantity).to eq 1
            expect(subject.cart.second.quantity).to eq 1
          end
        end

        describe 'shadow user is signed in' do
          before :each do
            @user = create(:lama_shadowed_user)
            allow(subject).to receive(:shadow_signed_in?).and_return(true)
            allow(subject).to receive(:current_shadow_user).and_return(@user)
            allow(subject).to receive(:user_signed_in?).and_return(false)
            allow(subject).to receive(:current_user).and_return(nil)
          end

          it 'adds product to cart' do
            product = create(:lama_product)
            subject.add_product_to_cart(product)
            expect(subject.cart.length).to eq 1
            expect(subject.cart.first.quantity).to eq 1
            expect(subject.cart.first.product).to eq product
            expect(subject.current_shadow_user.cart_user_products).to eq subject.cart
          end

          it 'adds same product to cart increasing quantity' do
            product = create(:lama_product)
            subject.add_product_to_cart(product)
            expect(subject.cart.length).to eq 1
            expect(subject.cart.first.quantity).to eq 1
            expect(subject.cart.first.product).to eq product

            subject.add_product_to_cart(product)
            subject.current_shadow_user.cart_user_products.reload
            expect(subject.cart.length).to eq 1
            expect(subject.cart.first.product).to eq product
            expect(subject.cart.first.quantity).to eq 2
          end

          it 'adds different products to cart' do
            product1 = create(:lama_product)
            product2 = create(:lama_product)
            subject.add_product_to_cart(product1)
            subject.add_product_to_cart(product2)
            subject.current_shadow_user.cart_user_products.reload

            expect(subject.cart.length).to eql 2
            expect(subject.cart.first.quantity).to eq 1
            expect(subject.cart.second.quantity).to eq 1
          end
        end

        describe 'add to cart and then sign in' do
          it 'as shadow' do
            allow(subject).to receive(:user_signed_in?).and_return(false)
            allow(subject).to receive(:current_user).and_return(nil)

            product1 = create(:lama_product)
            product2 = create(:lama_product)
            subject.add_product_to_cart(product1)
            subject.add_product_to_cart(product2)

            user = create(:lama_shadowed_user)
            subject.shadow_sign_in(user)

            expect(subject.cart.length).to eql 2
            expect(subject.cart.first.quantity).to eq 1
            expect(subject.cart.second.quantity).to eq 1
            expect(subject.session[:cart]).to be_empty
          end
        end
      end
    end
  end
end
