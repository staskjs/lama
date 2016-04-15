class CreateLamaOrders < ActiveRecord::Migration
  def change
    create_table :lama_orders do |t|
      t.integer :person_type_id
      t.boolean :payed, default: false
      t.datetime :payed_at
      t.boolean :cancelled, default: false
      t.datetime :cancelled_at
      t.text :cancelled_reason
      t.integer :order_status_id
      t.datetime :status_changed_at
      t.float :price
      t.float :discount
      t.string :currency
      t.integer :user_id
      t.integer :payment_system_id
      t.integer :delivery_system_id
      t.float :delivery_price
      t.boolean :allow_delivery, default: false
      t.datetime :allow_delivery_at
      t.string :ps_status
      t.string :ps_status_code
      t.text :ps_status_description
      t.string :ps_status_message
      t.float :ps_sum
      t.string :ps_currency
      t.datetime :ps_response_at
      t.float :tax_value
      t.string :delivery_doc_num
      t.datetime :delivery_doc_at
      t.string :tracking_number
      t.string :xml_id

      t.timestamps null: false
    end
  end
end
