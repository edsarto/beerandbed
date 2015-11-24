class AddAttachmentLicenceToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :licence
    end
  end

  def self.down
    remove_attachment :users, :licence
  end
end
