require 'rails'
require 'devise'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'friendly_id'
require 'jbuilder'
require 'lama/engine'

module Lama
  # autoload :Cart, 'lama/cart'

  module Controllers
    autoload :Helpers, 'lama/controllers/helpers'
  end

  def self.include_helpers
    ActiveSupport.on_load :action_controller do
      include Lama::Controllers::Helpers
    end

    ActiveSupport.on_load :action_view do
    end
  end
end
