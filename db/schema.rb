# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_25_101713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accountants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string "iban"
    t.string "account_name"
    t.integer "bankin_uu_id"
    t.string "swift"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_accounts_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "siren"
    t.string "siret"
    t.string "fiscal_regim"
    t.string "address"
    t.string "phone_number"
    t.bigint "accountant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accountant_id"], name: "index_companies_on_accountant_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.date "date"
    t.float "net_amount"
    t.string "issuer"
    t.float "vta"
    t.bigint "company_id", null: false
    t.string "payment_method"
    t.float "tax_amount"
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "total_amount"
    t.string "client"
    t.index ["company_id"], name: "index_invoices_on_company_id"
  end


  create_table "operations", force: :cascade do |t|
    t.date "date"
    t.float "amount"
    t.string "details"
    t.string "category"
    t.bigint "account_id", null: false
    t.bigint "invoice_id", null: false
    t.integer "bankin_uu_id"
    t.boolean "validated", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_operations_on_account_id"
    t.index ["invoice_id"], name: "index_operations_on_invoice_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "accountant_id"
    t.bigint "company_id"
    t.string "first_name"
    t.string "last_name"
    t.index ["accountant_id"], name: "index_users_on_accountant_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "companies"
  add_foreign_key "companies", "accountants"
  add_foreign_key "invoices", "companies"
  add_foreign_key "operations", "accounts"
  add_foreign_key "operations", "invoices"
  add_foreign_key "users", "accountants"
  add_foreign_key "users", "companies"
end
