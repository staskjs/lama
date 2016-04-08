module Lama
  class Section < ActiveRecord::Base
    include Concerns::Manageable

    # Parent section
    belongs_to :section

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
