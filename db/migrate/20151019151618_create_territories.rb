class CreateTerritories < ActiveRecord::Migration
  def change
    create_table :territories do |t|
      t.string :name
      t.text :description
      t.string :category
      t.integer :price
      t.string :street
      t.string :city
      t.string :zipcode
      t.integer :max_number_of_guests
      t.text :policy
      t.integer :owner_id, index: true

      t.timestamps null: false

    end
    add_foreign_key :territories, :users, column: :owner_id
  end
end
