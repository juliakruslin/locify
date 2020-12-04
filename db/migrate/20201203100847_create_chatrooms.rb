class CreateChatrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chatrooms do |t|
      t.string :name
      t.references :store, references: :users, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
