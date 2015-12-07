# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151207205139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "zipcode"
    t.string   "city"
    t.integer  "user_id"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "addresses", ["booking_id"], name: "index_addresses_on_booking_id", using: :btree
  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "beds", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "category"
    t.string   "street"
    t.string   "city"
    t.string   "zipcode"
    t.integer  "max_number_of_guests"
    t.text     "policy"
    t.integer  "owner_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.text     "direction"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "price_cents",          default: 0, null: false
  end

  add_index "beds", ["owner_id"], name: "index_beds_on_owner_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.date     "starting_on"
    t.date     "ending_on"
    t.string   "status"
    t.integer  "client_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.text     "message"
    t.boolean  "client_archive",       default: false
    t.boolean  "owner_archive",        default: false
    t.text     "confirmation_message"
    t.integer  "total_price_cents",    default: 0,     null: false
    t.string   "checkout_status"
    t.integer  "nb_days"
    t.integer  "bed_id"
  end

  add_index "bookings", ["bed_id"], name: "index_bookings_on_bed_id", using: :btree
  add_index "bookings", ["client_id"], name: "index_bookings_on_client_id", using: :btree

  create_table "credit_cards", force: :cascade do |t|
    t.string   "name"
    t.date     "expires_at"
    t.string   "mangopay_card_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "credit_cards", ["user_id"], name: "index_credit_cards_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "credit_card_id"
    t.integer  "amount_cents",      default: 0,     null: false
    t.string   "amount_currency",   default: "EUR", null: false
    t.json     "mangopay_response"
    t.integer  "booking_id"
    t.string   "state"
    t.string   "mangopay_payin_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "payments", ["booking_id"], name: "index_payments_on_booking_id", using: :btree
  add_index "payments", ["credit_card_id"], name: "index_payments_on_credit_card_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "bed_id"
  end

  add_index "photos", ["bed_id"], name: "index_photos_on_bed_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "comment"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["booking_id"], name: "index_reviews_on_booking_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "insurance_file_name"
    t.string   "insurance_content_type"
    t.integer  "insurance_file_size"
    t.datetime "insurance_updated_at"
    t.text     "bio"
    t.string   "mangopay_user_id"
    t.string   "mangopay_wallet_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "addresses", "bookings"
  add_foreign_key "addresses", "users"
  add_foreign_key "beds", "users", column: "owner_id"
  add_foreign_key "bookings", "beds"
  add_foreign_key "bookings", "users", column: "client_id"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "payments", "bookings"
  add_foreign_key "payments", "credit_cards"
  add_foreign_key "photos", "beds"
  add_foreign_key "reviews", "bookings"
end
