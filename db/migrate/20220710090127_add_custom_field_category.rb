class AddCustomFieldCategory < ActiveRecord::Migration[7.0]
  def change
    create_table :category_custom_fields, id: :uuid do |t|
      t.references :category, type: :uuid, unique: true
      t.references :custom_field, type: :uuid, unique: true
    end
  end
end
