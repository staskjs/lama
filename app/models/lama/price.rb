module Lama
  class Price < ActiveRecord::Base
    include Concerns::Manageable

    belongs_to :product

    belongs_to :price_type

    belongs_to :currency
  end
end
