module Lama
  class Currency < ActiveRecord::Base
    include Concerns::Manageable

    validates :name, presence: true
    validates :numcode, presence: true
  end
end
