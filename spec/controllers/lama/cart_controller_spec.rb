require 'rails_helper'

module Lama
  describe CartController, type: :controller do
    routes { Lama::Engine.routes }
    render_views

    it 'can add to cart' do
      get 'add', format: :json
      expect(parsed_body).to be_empty
    end
  end
end
