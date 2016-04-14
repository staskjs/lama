module Lama
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_one :cart

    # Used to create user without email and password
    attr_accessor :shadow

    def initialize
      self.shadow = false
      super
    end

    # Email and password are not required if user is created behind the curtains (shadowed)
    def email_required?
      !shadow
    end

    def password_required?
      !shadow
    end
  end
end
