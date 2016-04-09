module Lama
  class Product < ActiveRecord::Base
    include Concerns::Manageable

    # Main section
    belongs_to :section

    # Picture shown when user previews a product
    belongs_to :preview_picture, class_name: File, foreign_key: :preview_picture_file_id

    # Picture shown when user wants detailed information
    belongs_to :detail_picture, class_name: File, foreign_key: :detail_picture_file_id

    # Product can be categorized inside multiple sections
    has_many :product_sections, dependent: :delete_all
    has_many :sections, through: :product_sections

    # Product can have multiple prices in different currencies
    has_many :prices

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
