class AddVenderCountToMarkets < ActiveRecord::Migration[7.1]
  def change
    add_column :markets, :vender_count, :integer
  end
end
