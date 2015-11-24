class AddPriceToTerritories < ActiveRecord::Migration
  def change
    add_monetize :territories, :price, currency: { present: false }
  end
end
