class RemoveScoreFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :score, :integer
  end
end
