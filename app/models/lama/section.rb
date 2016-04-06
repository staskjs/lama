module Lama
  class Section < ActiveRecord::Base

    # Parent section
    belongs_to :section

    # User that has created this section
    belongs_to :creator, class_name: User, foreign_key: :created_user_id

    # User that has last updated this section
    belongs_to :updater, class_name: User, foreign_key: :updated_user_id

    # Picture shown when user previews a section
    belongs_to :preview_picture, class_name: File, foreign_key: :preview_picture_file_id

    # Picture shown when user wants detailed information
    belongs_to :detail_picture, class_name: File, foreign_key: :detail_picture_file_id

    # Section can have subsections
    # When section is deleted, destroy all subsections
    has_many :sections, dependent: :destroy

    # Section can categorize multiple products
    has_many :product_sections, dependent: :destroy
    has_many :products, through: :product_sections

  end
end
