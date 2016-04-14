module Lama
  class Cart < ActiveRecord::Base
    belongs_to :user
    belongs_to :order
    belongs_to :product
    belongs_to :product_price
    belongs_to :currency

    validates :user_id, presence: true
    validates :order_id, presence: true
    validates :product_id, presence: true
    validates :product_price_id, presence: true
    validates :currency_id, presence: true
  end
end
