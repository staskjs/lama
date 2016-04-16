module Lama
  class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :currency
    belongs_to :person_type
  end
end
