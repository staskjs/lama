require 'rails_helper'

#
module Lama
  describe User, type: :model do
    describe 'not shadowed' do
      it 'can not be created without email' do
        # Create empty user which is not valid
        user = build(:lama_empty_user)
        expect(user.valid?).to be false
        user.save
        expect(user).to have(1).errors_on(:email)
        expect(user).to have(1).errors_on(:password)

        # User with filled in email and password is valid
        user = build(:lama_user)
        expect(user.valid?).to be true
      end
    end

    describe 'shadowed' do
      it 'can be created without email' do
        user = build(:lama_shadowed_user)
        expect(user.valid?).to be true
      end
    end
  end
end
