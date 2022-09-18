# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_18_154618) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.text "slug"
    t.jsonb "image_data"
    t.uuid "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "listings_count", default: 0
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "category_custom_fields", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "category_id"
    t.uuid "custom_field_id"
    t.index ["category_id"], name: "index_category_custom_fields_on_category_id"
    t.index ["custom_field_id"], name: "index_category_custom_fields_on_custom_field_id"
  end

  create_table "custom_fields", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.jsonb "meta", default: {}
    t.string "custom_field_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "listing_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "listing_id"
    t.jsonb "image_data"
    t.index ["listing_id"], name: "index_listing_images_on_listing_id"
  end

  create_table "listings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "category_id"
    t.uuid "profile_id"
    t.string "title"
    t.text "desc"
    t.jsonb "field_values", default: {}
    t.boolean "active", default: true, null: false
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.float "price", default: 0.0
    t.jsonb "image_data", default: {}
    t.index "(((field_values ->> 'field_id'::text))::uuid)", name: "idx_field_values"
    t.index ["category_id", "price"], name: "index_listings_on_category_id_and_price"
    t.index ["category_id"], name: "index_listings_on_category_id"
    t.index ["profile_id"], name: "index_listings_on_profile_id"
    t.index ["slug"], name: "index_listings_on_slug", unique: true
    t.index ["title"], name: "index_listings_on_title"
  end

  create_table "profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "profile_type", default: "Profile::User"
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "country"
    t.string "city"
    t.string "address_1"
    t.string "address_2"
    t.string "postal_code"
    t.string "gender"
    t.string "language"
    t.string "currency"
    t.string "time_zone"
    t.jsonb "avatar_data"
    t.jsonb "cover_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_profiles_on_slug", unique: true
  end

  create_table "refresh_tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "token"
    t.uuid "user_id", null: false
    t.datetime "expire_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_refresh_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "user_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "profile_id"
    t.boolean "current", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_user_profiles_on_profile_id"
    t.index ["user_id", "profile_id"], name: "index_user_profiles_on_user_id_and_profile_id", unique: true
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.datetime "last_login_at"
    t.string "last_login_country"
    t.inet "last_login_ip"
    t.string "current_login_at"
    t.string "current_login_country"
    t.inet "current_login_ip"
    t.integer "login_count"
    t.inet "allowed_ips", default: [], array: true
    t.string "confirmation_email_token"
    t.string "confirmation_phone_token"
    t.datetime "confirmed_email_at"
    t.datetime "confirmed_phone_at"
    t.boolean "opt_required", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "phone"], name: "index_users_on_email_and_phone", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

  add_foreign_key "listing_images", "listings"
  add_foreign_key "refresh_tokens", "users"
end
