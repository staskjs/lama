require 'rails'
require 'devise'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'friendly_id'
require 'jbuilder'
require 'lama/engine'

# rubocop:disable Style/ClassVars
module Lama
  # autoload :Cart, 'lama/cart'

  module Controllers
    autoload :ShadowUserHelper, 'lama/controllers/shadow_user_helper'
    autoload :CartHelper, 'lama/controllers/cart_helper'
  end

  def self.include_helpers
    ActiveSupport.on_load :action_controller do
      include Lama::Controllers::ShadowUserHelper
      include Lama::Controllers::CartHelper
    end

    ActiveSupport.on_load :action_view do
    end
  end

  # Defines whether cart should be deleted from session
  # and transfered to database after sign in,
  # or just copied
  mattr_accessor :clear_session_cart_after_sign_in
  @@clear_session_cart_after_sign_in = true

  # Can be used in initializer to change default settings
  # example:
  #     Lama.setup do |config|
  #         config.key = value
  #     end
  def self.setup
    yield self
  end
end
