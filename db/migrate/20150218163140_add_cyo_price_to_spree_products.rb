class AddCyoPriceToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :cyo_price, :boolean, default: false
  end
end
