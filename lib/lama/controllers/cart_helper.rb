module Lama
  module Controllers
    module CartHelper
      extend ActiveSupport::Concern

      included do
        helper_method :cart if respond_to?(:helper_method)
      end

      # Add product to cart
      def add_product_to_cart(product)
        if !product || product.new_record?
          raise I18n.t 'lama.cart.add_not_existing_product'
        end

        if user_signed_in?
          add_to_db_cart(product, current_user)
        elsif shadow_signed_in?
          add_to_db_cart(product, current_shadow_user)
        else
          add_to_session_cart(product)
        end
      end

      # Get cart from session
      def cart
        if user_signed_in?
          current_user.cart_user_products
        elsif shadow_signed_in?
          current_shadow_user.cart_user_products
        else
          session[:cart] ||= []
          UserProduct.where(id: session[:cart]).all
        end
      end

      private

      # Cart of unauthorized user is stored in a session
      def add_to_session_cart(product)
        if session[:cart]
          user_product = UserProduct.where(id: session[:cart], product_id: product.id).first
          if user_product.nil?
            user_product = UserProduct.create(product_id: product.id)
          else
            user_product.increment!(:quantity)
          end
        else
          user_product = UserProduct.create(product_id: product.id)
          session[:cart] = []
        end
        session[:cart] << user_product.id
      end

      def add_to_db_cart(product, user)
        user_product = UserProduct.where(user_id: user.id, product_id: product.id).first
        if user_product.nil?
          UserProduct.create(user_id: user.id, product_id: product.id)
        else
          user_product.increment!(:quantity)
        end
      end
    end
  end
end
