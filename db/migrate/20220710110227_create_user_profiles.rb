class CreateUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles, id: :uuid do |t|
      t.references :user, type: :uuid, index: true
      t.references :profile, type: :uuid, index: true
      t.boolean :current, default: false
      t.index(%i[user_id profile_id], unique: true)
      t.timestamps
    end
  end
end
