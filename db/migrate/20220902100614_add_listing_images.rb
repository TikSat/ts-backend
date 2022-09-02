class AddListingImages < ActiveRecord::Migration[7.0]
  def change
    create_table :listing_images, id: :uuid do |t|
      t.references :listing, foreign_key: true, type: :uuid, index: true
      t.jsonb :image_data
    end
  end
end
