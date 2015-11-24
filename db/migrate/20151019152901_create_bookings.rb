class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.integer :total_price
      t.string :status
      t.references :territory, index: true, foreign_key: true
      t.integer :client_id, index: true

      t.timestamps null: false

    end
    add_foreign_key :bookings, :users, column: :client_id
  end
end
