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

ActiveRecord::Schema.define(version: 20140918162229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "name",       default: "", null: false
    t.string   "path",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credit_lines", force: true do |t|
    t.string   "name",            default: "",  null: false
    t.float    "annual_interest", default: 0.0, null: false
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credit_lines", ["account_id"], name: "index_credit_lines_on_account_id", using: :btree

  create_table "credit_plans", force: true do |t|
    t.string   "document",       default: "",           null: false
    t.date     "birth_date",     default: '2014-09-29', null: false
    t.float    "amount",         default: 0.0,          null: false
    t.string   "state",          default: "En Proceso", null: false
    t.integer  "months",         default: 0,            null: false
    t.integer  "risk_level"
    t.integer  "account_id"
    t.integer  "credit_line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credit_plans", ["account_id"], name: "index_credit_plans_on_account_id", using: :btree
  add_index "credit_plans", ["credit_line_id"], name: "index_credit_plans_on_credit_line_id", using: :btree

  create_table "fees", force: true do |t|
    t.integer  "month"
    t.float    "interest"
    t.float    "amortization"
    t.float    "payment"
    t.float    "balance"
    t.integer  "credit_plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fees", ["credit_plan_id"], name: "index_fees_on_credit_plan_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name",                   default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "company_name",           default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
