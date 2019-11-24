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

ActiveRecord::Schema.define(version: 2019_11_22_030955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "payouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount", null: false
    t.string "currency"
    t.integer "status", default: 2
    t.uuid "account_id"
    t.uuid "transfer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_payouts_on_account_id"
    t.index ["transfer_id"], name: "index_payouts_on_transfer_id"
  end

  create_table "transfers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount", null: false
    t.decimal "exchange_rate"
    t.string "target_currency"
    t.string "source_currency"
    t.integer "status", default: 2
    t.uuid "sender_account_id", null: false
    t.uuid "receiver_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_account_id"], name: "index_transfers_on_receiver_account_id"
    t.index ["sender_account_id"], name: "index_transfers_on_sender_account_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest", default: "", null: false
    t.string "name", default: ""
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "payouts", "accounts"
  add_foreign_key "payouts", "transfers"
  add_foreign_key "transfers", "accounts", column: "receiver_account_id"
  add_foreign_key "transfers", "accounts", column: "sender_account_id"
end
