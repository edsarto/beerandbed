class AddAttachmentStampToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :stamp
    end
  end

  def self.down
    remove_attachment :users, :stamp
  end
end
