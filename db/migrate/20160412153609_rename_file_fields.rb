class RenameFileFields < ActiveRecord::Migration
  def change
    rename_column :lama_products, :preview_picture_file_id, :preview_picture
    rename_column :lama_products, :detail_picture_file_id, :detail_picture

    rename_column :lama_sections, :preview_picture_file_id, :preview_picture
    rename_column :lama_sections, :detail_picture_file_id, :detail_picture
  end
end
