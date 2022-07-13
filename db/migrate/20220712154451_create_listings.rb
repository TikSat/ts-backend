class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings, id: :uuid do |t|
      t.references :category, type: :uuid, index: true
      t.references :author, type: :uuid, index: true, foreign_key: { to_table: :user_profiles }
      t.jsonb :field_values
      t.boolean :active, default: true, null: false
      t.datetime :expires_at

      t.timestamps
    end
  end
end
