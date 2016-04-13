module Lama
  #
  class CartController < ActionController::Base
    def add
      render json: :no_content
    end
  end
end
