class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :phone
      t.string :password

      t.datetime :last_login_at
      t.string :last_login_country
      t.inet :last_login_ip

      t.string :current_login_at
      t.string :current_login_country
      t.inet :current_login_ip

      t.integer :login_count
      t.inet :allowed_ips, array: true, default: []

      t.string :confirmation_email_token
      t.string :confirmation_phone_token
      t.datetime :confirmed_email_at
      t.datetime :confirmed_phone_at

      t.boolean :opt_required, default: false

      t.index :email, unique: true
      t.index :phone, unique: true
      t.index(%i[email phone], unique: true)

      t.timestamps
    end
  end
end
