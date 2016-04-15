class RemoveOrdersUserId < ActiveRecord::Migration
  def change
    remove_column :lama_orders, :user_id, :integer
  end
end
