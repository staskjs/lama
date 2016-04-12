module Lama
  class Section < ActiveRecord::Base
    include Concerns::Manageable

    # Picture shown when user previews a section
    mount_uploader :preview_picture, PictureUploader

    # Picture shown when user wants detailed information
    mount_uploader :detail_picture, PictureUploader

    # Parent section
    belongs_to :section

    # Section can have subsections
    # When section is deleted, destroy all subsections
    has_many :sections, dependent: :destroy

    # Section can categorize multiple products
    has_many :product_sections, dependent: :destroy
    has_many :products, through: :product_sections
  end
end
