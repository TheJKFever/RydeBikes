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

ActiveRecord::Schema.define(version: 20150211215205) do

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "apt"
    t.string "city"
    t.string "zipcode"
    t.string "state"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id"
    t.string  "provider"
    t.string  "uid"
    t.string  "token"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id"

  create_table "bikes", force: :cascade do |t|
    t.string   "status"
    t.integer  "ride_id"
    t.integer  "location_id"
    t.string   "model"
    t.integer  "network_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "bikes", ["location_id"], name: "index_bikes_on_location_id"
  add_index "bikes", ["network_id"], name: "index_bikes_on_network_id"
  add_index "bikes", ["ride_id"], name: "index_bikes_on_ride_id"
  add_index "bikes", ["status"], name: "index_bikes_on_status"

  create_table "coordinates", force: :cascade do |t|
    t.integer "network_id"
    t.float   "latitude"
    t.float   "longitude"
    t.string  "name"
    t.string  "full_address"
  end

  add_index "coordinates", ["latitude", "longitude"], name: "index_coordinates_on_latitude_and_longitude"
  add_index "coordinates", ["network_id"], name: "index_coordinates_on_network_id"

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

  add_index "networks", ["domain"], name: "index_networks_on_domain"

  create_table "rides", force: :cascade do |t|
    t.integer  "bike_id"
    t.integer  "user_id"
    t.integer  "start_location_id"
    t.integer  "stop_location_id"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.string   "status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "rides", ["bike_id"], name: "index_rides_on_bike_id"
  add_index "rides", ["stop_time"], name: "index_rides_on_stop_time"
  add_index "rides", ["user_id", "status"], name: "index_rides_on_user_id_and_status"
  add_index "rides", ["user_id"], name: "index_rides_on_user_id"

  create_table "transactions", force: :cascade do |t|
    t.integer  "cc_id"
    t.string   "payment_type"
    t.integer  "user_id"
    t.integer  "ride_id"
    t.float    "amount"
    t.string   "status"
    t.string   "details"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "transactions", ["ride_id"], name: "index_transactions_on_ride_id"
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.boolean  "admin",                  default: false
    t.integer  "network_id"
    t.string   "picture"
    t.string   "name"
    t.string   "phone"
    t.integer  "address_id"
    t.string   "status"
    t.string   "username",               default: "",    null: false
    t.string   "email"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "braintree_id"
    t.boolean  "first_time_login",       default: true
    t.string   "access_token"
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
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["network_id"], name: "index_users_on_network_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
