module Lama
  class Order < ActiveRecord::Base
    enum status: [:pending, :processed, :shipping, :shipped, :returned]

    belongs_to :user
    belongs_to :currency
    belongs_to :person_type
    belongs_to :payment_system
  end
end
