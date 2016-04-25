module Lama
  class Product < ActiveRecord::Base
    include Concerns::Manageable
    extend FriendlyId

    # Picture shown when user previews a product
    mount_uploader :preview_picture, Lama.picture_uploader

    # Picture shown when user wants detailed information
    mount_uploader :detail_picture, Lama.picture_uploader

    # Use name as a slug
    friendly_id :name, use: :slugged

    # Main section
    belongs_to :section

    # Product can be categorized inside multiple sections
    has_many :product_sections, dependent: :delete_all
    has_many :sections, through: :product_sections

    # Product can have multiple prices in different currencies
    has_many :prices

    # Product can be contained in multiple carts
    has_many :carts

    scope :active, -> { where(active: true) }

    # Check uniqueness of prices unless same validation error already came from Price model
    validate :uniqueness_of_prices, if: -> { errors[:prices].empty? }

    # Check if prices connection contains duplicate prices by price_type and currency
    def uniqueness_of_prices
      has_duplicates =
        prices
        .map { |price| [price.price_type_id, price.currency] }
        .each_with_object(Hash.new(0)) { |price, counts| counts[price] += 1 }
        .values
        .any? { |count| count > 1 }

      errors.add(:prices, :unique) if has_duplicates
    end
  end
end
