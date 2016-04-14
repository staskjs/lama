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
          raise I18n.t 'lama.errors.user_is_not_shadowed'
        end
        session[:shadow_user_id] = user.id
      end

      # Get current shadow user if exists
      def current_shadow_user
        @current_shadow_user ||= User.find(session[:shadow_user_id]) if session[:shadow_user_id]
      end
    end
  end
end
