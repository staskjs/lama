module Lama
  module Controllers
    module CartHelper
      extend ActiveSupport::Concern

      included do
        helper_method :cart if respond_to?(:helper_method)
      end

      def cart
        @cart ||= Cart.new(self)
      end
    end
  end
end
