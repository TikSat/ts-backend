class AddSlugToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :slug, :string
    add_column :profiles, :slug, :string
    add_index :listings, :slug, unique: true
    add_index :categories, :slug, unique: true
    add_index :profiles, :slug, unique: true
  end
end
