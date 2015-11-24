class AddBedToPhoto < ActiveRecord::Migration
  def change
    add_reference :photos, :bed, index: true, foreign_key: true

  end
end
