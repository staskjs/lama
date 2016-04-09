module Lama
  class Price < ActiveRecord::Base
    include Concerns::Manageable

    belongs_to :product

    belongs_to :price_type

    belongs_to :currency

    validates :product_id, uniqueness: { scope: [:price_type_id, :currency_id] }
  end
end
