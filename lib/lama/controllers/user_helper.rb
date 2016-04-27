module Lama
  module Controllers
    module UserHelper
      extend ActiveSupport::Concern

      # Override devise sign_in method to transfer cart to user
      def sign_in(*args)
        super(*args)
        cart.transfer_to_user(current_user)
      end
    end
  end
end
