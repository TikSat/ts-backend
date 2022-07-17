class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings, id: :uuid do |t|
      t.references :category, type: :uuid, index: true
      t.references :profile, type: :uuid, index: true
      t.string :title, index: true
      t.text :desc
      t.jsonb :field_values, default: {}
      t.boolean :active, default: true, null: false
      t.datetime :expires_at

      t.timestamps
    end
  end
end
