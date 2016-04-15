module Lama
  class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :currency
  end
end
