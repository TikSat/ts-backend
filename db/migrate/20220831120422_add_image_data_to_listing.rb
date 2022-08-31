class AddImageDataToListing < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :image_data, :jsonb, default: {}
  end
end
