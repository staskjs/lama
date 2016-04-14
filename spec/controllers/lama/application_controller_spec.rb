require 'rails_helper'

module Lama
  describe ApplicationController, type: :controller do
    routes { Lama::Engine.routes }
    render_views

    describe 'helper methods' do
      describe 'shadowed users' do
        it 'can sign in' do
          expect(subject.user_signed_in?).to eq false
          expect(subject.shadow_signed_in?).to eq false

          user = create(:lama_shadowed_user)
          subject.shadow_sign_in user

          expect(subject.user_signed_in?).to eq false
          expect(subject.shadow_signed_in?).to eq true
          expect(subject.current_shadow_user).to eq user
          expect(subject.current_user).to eq nil
        end

        it 'cannot sign in not shadowed user' do
          user = create(:lama_user)
          expect { subject.shadow_sign_in user }.to raise_error I18n.t 'lama.errors.user_is_not_shadowed'
        end
      end
    end
  end
end
