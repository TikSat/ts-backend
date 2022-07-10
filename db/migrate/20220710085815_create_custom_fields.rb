class CreateCustomFields < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_fields, id: :uuid do |t|
      t.string :name
      t.text :desc
      t.jsonb :meta, default: {}
      t.string :custom_field_type
      t.timestamps
    end
  end
end
