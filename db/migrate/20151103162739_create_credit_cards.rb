class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.date :expires_at
      t.string :mangopay_card_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
