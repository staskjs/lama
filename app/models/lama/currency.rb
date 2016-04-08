module Lama
  class Currency < ActiveRecord::Base
    include Concern::Manageable
  end
end
