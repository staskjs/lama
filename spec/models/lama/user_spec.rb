require 'rails_helper'

#
module Lama
  describe User, type: :model do
    describe 'not shadowed' do
      it 'can not be created without email' do
        user = build(:lama_user)
        expect(user.valid?).to be false
        user.save
        expect(user).to have(1).errors_on(:email)
        expect(user).to have(1).errors_on(:password)
      end
    end

    describe 'shadowed' do
      it 'can be created without email' do
        user = build(:shadowed_lama_user)
        expect(user.valid?).to be true
      end
    end
  end
end
