class CreateWishlist < ActiveRecord::Migration[6.0]
  def change
    create_table :wishlists do |t|
      t.references :product
      t.references :user
    end
  end
end
