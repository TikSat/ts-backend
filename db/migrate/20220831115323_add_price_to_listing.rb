class AddPriceToListing < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :price, :float, default: 0
    add_index :listings, %i[category_id price]
  end
end
