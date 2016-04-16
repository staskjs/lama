class CreateLamaPersonTypes < ActiveRecord::Migration
  def change
    create_table :lama_person_types do |t|
      t.string :name
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
