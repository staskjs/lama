module Lama
  module Controllers
    module CartHelper
      extend ActiveSupport::Concern

      included do
        if respond_to?(:helper_method)
          helper_method :cart
        end
      end

      # Add product to cart
      def add_product_to_cart(product)
        if !product || product.new_record?
          # TODO: translate
          raise 'Cannot save non-existing product'
        end

        if session[:cart]
          user_product = UserProduct.where(id: session[:cart], product_id: product.id).first
          user_product.increment!(:quantity)
        else
          user_product = UserProduct.create(product_id: product.id)
          session[:cart] = []
        end
        session[:cart] << user_product.id
      end

      # Get cart from session
      def cart
        session[:cart] ||= []
        UserProduct.where(id: session[:cart]).all
      end
    end
  end
end
