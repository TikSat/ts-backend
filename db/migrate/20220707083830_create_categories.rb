class CreateCategories < ActiveRecord::Migration[7.0]
  enable_extension 'pgcrypto'

  def change
    create_table :categories, id: :uuid do |t|
      t.string :name
      t.text :desc
      t.text :slug, unique: true
      t.jsonb :image_data
      t.uuid :parent_id

      t.timestamps
    end
  end
end
