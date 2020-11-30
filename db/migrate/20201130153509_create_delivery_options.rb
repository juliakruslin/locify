class CreateDeliveryOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_options do |t|
      t.string :name
      t.references :product, null: false, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
