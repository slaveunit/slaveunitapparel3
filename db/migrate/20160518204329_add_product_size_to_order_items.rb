class AddProductSizeToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :product_size, :string
  end
end
