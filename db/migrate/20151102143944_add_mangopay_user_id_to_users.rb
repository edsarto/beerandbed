class AddMangopayUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mango_pay_user_id, :string
  end
end
