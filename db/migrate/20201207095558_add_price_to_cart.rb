class AddPriceToCart < ActiveRecord::Migration[6.0]
  def change
    remove_column :carts, :total_price
    add_monetize :carts, :price, currency: { present: false }
  end
end
