require 'rails_helper'

module Lama
  describe ApplicationController, type: :controller do
    routes { Lama::Engine.routes }
    render_views
  end
end
