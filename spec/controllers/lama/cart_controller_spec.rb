require 'rails_helper'

module Lama
  describe CartController, type: :controller do
    routes { Lama::Engine.routes }

    it 'can add to cart' do
      get 'add'
      expect(response.body).to eq :no_content.to_json
    end
  end
end
