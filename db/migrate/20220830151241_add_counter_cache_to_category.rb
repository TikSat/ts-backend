class AddCounterCacheToCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :listings_count, :integer, default: 0
  end
end
