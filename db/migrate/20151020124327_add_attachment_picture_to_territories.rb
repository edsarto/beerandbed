class AddAttachmentPictureToTerritories < ActiveRecord::Migration
  def self.up
    change_table :territories do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :territories, :picture
  end
end
