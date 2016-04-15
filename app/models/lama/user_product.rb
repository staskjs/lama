module Lama
  class UserProduct < ActiveRecord::Base
    belongs_to :user
    belongs_to :order
    belongs_to :product
    belongs_to :product_price
    belongs_to :currency

    validates :product_id, presence: true
  end
end
