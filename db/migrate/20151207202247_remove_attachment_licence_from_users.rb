class RemoveAttachmentLicenceFromUsers < ActiveRecord::Migration
  def change
    remove_attachment :users, :licence
  end
end
