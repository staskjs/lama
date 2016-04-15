module Lama
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_many :ordered_user_products, -> { where('order_id IS NOT NULL') }, class_name: UserProduct, dependent: :destroy

    # Cart is basically selected products that were not yet ordered
    has_many :cart_user_products, -> { where('order_id IS NULL') }, class_name: UserProduct, dependent: :destroy

    # User can make multiple orders
    has_many :orders, through: :ordered_user_products

    # Products that user ordered
    has_many :ordered_products, through: :ordered_user_products, source: :product

    # Products in the cart
    has_many :cart_products, through: :cart_user_products, source: :product

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
