class AddDefaultToChartItems < ActiveRecord::Migration[6.0]
  def change
    change_column :cart_items, :amount, :integer, default: 0
  end
end
