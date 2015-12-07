class RemoveAttachmentStampFromUsers < ActiveRecord::Migration
  def change
    remove_attachment :users, :stamp
  end
end
