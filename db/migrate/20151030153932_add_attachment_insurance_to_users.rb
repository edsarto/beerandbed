class AddAttachmentInsuranceToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :insurance
    end
  end

  def self.down
    remove_attachment :users, :insurance
  end
end
