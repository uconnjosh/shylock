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

ActiveRecord::Schema.define(version: 20170429211026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "apr"
    t.string   "credit_limit"
    t.string   "open_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "statements", force: :cascade do |t|
    t.date     "begin_date"
    t.date     "end_date"
    t.float    "beginning_balance"
    t.float    "ending_balance"
    t.float    "interest_charged"
    t.integer  "account_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "for"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "account_id"
    t.boolean  "interest_charge"
    t.integer  "statement_id"
    t.decimal  "amount",          precision: 18, scale: 2
    t.index ["account_id"], name: "index_transactions_on_account_id", using: :btree
  end

  add_foreign_key "transactions", "accounts"
end
