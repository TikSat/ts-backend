class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :profile_type, default: 'Profile::User'
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :country
      t.string :city
      t.string :address_1
      t.string :address_2
      t.string :postal_code
      t.string :gender
      t.string :language
      t.string :currency
      t.string :time_zone
      t.jsonb :avatar_data
      t.jsonb :cover_data
      t.timestamps
    end
  end
end
