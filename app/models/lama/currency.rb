module Lama
  class Currency < ActiveRecord::Base
    include Concerns::Manageable
  end
end
