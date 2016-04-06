module Lama
  class Product < ActiveRecord::Base

    # Main section
    belongs_to :section

    # User that has created this product
    belongs_to :creator, class_name: User, foreign_key: :created_user_id

    # User that has last updated this product
    belongs_to :updater, class_name: User, foreign_key: :updated_user_id

    # Picture shown when user previews a product
    belongs_to :preview_picture, class_name: File, foreign_key: :preview_picture_file_id

    # Picture shown when user wants detailed information
    belongs_to :detail_picture, class_name: File, foreign_key: :detail_picture_file_id

    # Product can be categorized inside multiple sections
    has_many :product_sections, dependent: :delete_all
    has_many :sections, through: :product_sections

  end
end
