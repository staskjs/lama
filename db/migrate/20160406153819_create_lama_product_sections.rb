class CreateLamaProductSections < ActiveRecord::Migration
  def change
    create_table :lama_product_sections do |t|
      t.integer :product_id
      t.integer :section_id

      t.timestamps null: false
    end
  end
end
