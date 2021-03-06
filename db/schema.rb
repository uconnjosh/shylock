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

ActiveRecord::Schema.define(version: 20170502151059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "open_date"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.decimal  "apr",          precision: 4,  scale: 4
    t.decimal  "credit_limit", precision: 18, scale: 2
    t.integer  "user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
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
    t.string   "currency"
    t.index ["account_id"], name: "index_transactions_on_account_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "address"
    t.boolean  "superuser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
  end

  add_foreign_key "transactions", "accounts"
end
