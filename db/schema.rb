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

ActiveRecord::Schema.define(version: 20150220075211) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "apt"
    t.string   "city"
    t.string   "zipcode"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bikes", force: :cascade do |t|
    t.string   "status"
    t.integer  "location_id"
    t.string   "model"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "network_id"
    t.integer  "ride_id"
  end

  create_table "coordinates", force: :cascade do |t|
    t.float  "latitude"
    t.float  "longitude"
    t.string "name"
    t.string "full_address"
  end

  create_table "interests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "networks", force: :cascade do |t|
    t.string "name"
    t.string "domain"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "payment_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "last4"
    t.integer  "exp_month"
    t.integer  "exp_year"
    t.string   "stripe_customer_id"
  end

  create_table "payments_users", id: false, force: :cascade do |t|
    t.integer "payment_id", null: false
    t.integer "user_id",    null: false
  end

  create_table "rides", force: :cascade do |t|
    t.integer  "bike_id"
    t.integer  "user_id"
    t.integer  "start_location"
    t.integer  "stop_location"
    t.integer  "start_time"
    t.integer  "stop_time"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "rides", ["user_id", "status"], name: "index_rides_on_user_id_and_status"

  create_table "transactions", force: :cascade do |t|
    t.integer  "payment_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "ride_id"
    t.integer  "amount"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "address_id"
    t.string   "service_type"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "network_id"
    t.string   "picture"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
