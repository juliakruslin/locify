class RemoveDeliveryOptionsfromCartItems < ActiveRecord::Migration[6.0]
  def change
    remove_reference :cart_items, :delivery_option, foreign_key: true
  end
end
