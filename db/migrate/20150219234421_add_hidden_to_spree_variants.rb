class AddHiddenToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :hidden, :boolean, default: false
  end
end
