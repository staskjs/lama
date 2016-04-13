require 'rails'
require 'devise'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'friendly_id'
require 'jbuilder'
require 'lama/engine'

module Lama
  autoload :Cart, 'lama/cart'
end
