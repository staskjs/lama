module Lama
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        if respond_to?(:helper_method)
          helper_method :shadow_signed_in?, :current_shadow_user
        end
      end

      # Is user signed in as shadow
      def shadow_signed_in?
        session[:shadow_user_id].present?
      end

      # Sign in shadow user
      def shadow_sign_in(user)
        if !user.shadow || user.new_record?
          # TODO: translate
          raise 'Cannot sign in not shadowed user'
        end
        session[:shadow_user_id] = user.id
      end

      # Get current shadow user if exists
      def current_shadow_user
        @current_shadow_user ||= User.find(session[:shadow_user_id]) if session[:shadow_user_id]
      end

      #
      def add_product_to_shadow_cart(user_product)
        if !user_product || user_product.new_record? || user_product.order_id.present?
          # TODO: translate
          raise 'Cannot save non-existing cart'
        end
        session[:cart] ||= []
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
