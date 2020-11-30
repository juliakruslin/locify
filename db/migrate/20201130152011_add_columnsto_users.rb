class AddColumnstoUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :description, :text
    add_column :users, :street_name, :string
    add_column :users, :street_number, :string
    add_column :users, :city, :string
    add_column :users, :postal_code, :integer
    add_column :users, :seller_approved, :boolean, default: false
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
    add_column :users, :company_name, :string
  end
end
