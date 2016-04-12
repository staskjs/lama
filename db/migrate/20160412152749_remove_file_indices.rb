class RemoveFileIndices < ActiveRecord::Migration
  def change
    remove_index :lama_products, column: :detail_picture_file_id
    remove_index :lama_products, column: :preview_picture_file_id

    remove_index :lama_sections, column: :detail_picture_file_id
    remove_index :lama_sections, column: :preview_picture_file_id
  end
end
