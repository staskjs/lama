module Lama
  class Order < ActiveRecord::Base
    belongs_to :user
  end
end
