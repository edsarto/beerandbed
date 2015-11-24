class AddMangopayWalletIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :mangopay_wallet_id, :string
  end
end
