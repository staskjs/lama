require 'rails_helper'

module Lama
  module Controllers
    describe ShadowUserHelper, type: :helper do
      describe 'shadowed users' do
        it 'can sign in' do
          expect(helper.shadow_signed_in?).to eq false

          user = create(:lama_shadowed_user)
          helper.shadow_sign_in user

          expect(helper.shadow_signed_in?).to eq true
          expect(helper.current_shadow_user).to eq user
        end

        it 'cannot sign in not shadowed user' do
          user = create(:lama_user)
          expect { helper.shadow_sign_in user }.to raise_error I18n.t 'lama.shadow_user.cannot_sign_in'
        end
      end
    end
  end
end
