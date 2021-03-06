class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.float :total_price
      t.references :user, null: false, foreign_key: true
      t.integer :order_number
      t.string :status

      t.timestamps
    end
  end
end
