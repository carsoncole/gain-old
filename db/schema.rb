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

ActiveRecord::Schema.define(version: 2019_04_10_180626) do

  create_table "accounts", force: :cascade do |t|
    t.string "title"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts_users", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "user_id", null: false
    t.index ["account_id", "user_id"], name: "index_accounts_users_on_account_id_and_user_id"
    t.index ["user_id", "account_id"], name: "index_accounts_users_on_user_id_and_account_id"
  end

  create_table "issuers", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "securities", force: :cascade do |t|
    t.integer "account_id"
    t.integer "issuer_id"
    t.string "name"
    t.boolean "is_active", default: true, null: false
    t.string "currency", default: "usd", null: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_securities_on_account_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.date "date"
    t.integer "account_id"
    t.integer "security_id"
    t.decimal "price", precision: 15, scale: 5
    t.decimal "quantity", precision: 12, scale: 2
    t.decimal "accrued_interest", precision: 12, scale: 2
    t.decimal "commission", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "other", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "amount", precision: 12, scale: 2
    t.decimal "security_balance", precision: 15, scale: 5
    t.decimal "cash_balance", precision: 12, scale: 2
    t.string "transaction_type"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "date", "created_at", "type"], name: "index_on_date_created_and_type"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["security_id"], name: "index_transactions_on_security_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.boolean "is_owner", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
