class FixColumnNameToUser < ActiveRecord::Migration
  def change
    rename_column :users, :mango_pay_user_id, :mangopay_user_id
  end
end
