class ChangeOrderStatusIdToStatus < ActiveRecord::Migration
  def change
    rename_column :lama_orders, :order_status_id, :status
  end
end
