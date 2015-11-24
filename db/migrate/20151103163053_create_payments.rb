class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :credit_card, index: true, foreign_key: true
      t.monetize :amount
      t.json :mangopay_response
      t.references :booking, index: true, foreign_key: true
      t.string :state
      t.string :mangopay_payin_id

      t.timestamps null: false
    end
  end
end
