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

ActiveRecord::Schema.define(version: 2020_08_12_132100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absents", force: :cascade do |t|
    t.datetime "date"
    t.integer "status_absent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "active"
    t.bigint "employee_id"
    t.datetime "entry_hour"
    t.datetime "out_hour"
    t.index ["employee_id"], name: "index_absents_on_employee_id"
  end

  create_table "banks", force: :cascade do |t|
    t.integer "bank_account_number", default: 0
    t.string "bank_name"
    t.string "owner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cash_receipt_histories", force: :cascade do |t|
    t.bigint "cash_receipt_id"
    t.integer "total_deduce"
    t.integer "remaining_deduction"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cash_receipt_id"], name: "index_cash_receipt_histories_on_cash_receipt_id"
  end

  create_table "cash_receipts", force: :cascade do |t|
    t.integer "total_cash_receipt", default: 0
    t.integer "monthly_deduction", default: 0
    t.integer "cash_receipt_term", default: 0
    t.integer "rest_receipt_term", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "employee_id"
    t.boolean "status"
    t.integer "deduce_type", default: 0
    t.index ["employee_id"], name: "index_cash_receipts_on_employee_id"
  end

  create_table "cuti_histories", force: :cascade do |t|
    t.bigint "employee_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status"
    t.integer "sisa", default: 0
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_cuti_histories_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "employee_name"
    t.string "email"
    t.string "phone_number"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "join"
    t.integer "total_absent_monthly", default: 0
    t.integer "total_absent", default: 0
    t.integer "total_work_hour", default: 0
    t.integer "leave_rasio", default: 0
    t.bigint "position_id"
    t.string "id_bank", default: "0"
    t.string "bank_name"
    t.string "user_bank"
    t.index ["position_id"], name: "index_employees_on_position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "position_name"
    t.integer "positional_allowance", default: 0
    t.integer "transportation_allowance", default: 0
    t.integer "meal_allowances", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "salary", default: 0
  end

  create_table "rekaps", force: :cascade do |t|
    t.string "expanse_name"
    t.integer "date"
    t.integer "total_expenditure"
    t.bigint "stocks_id"
    t.bigint "sallaries_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sallaries_id"], name: "index_rekaps_on_sallaries_id"
    t.index ["stocks_id"], name: "index_rekaps_on_stocks_id"
  end

  create_table "salary_histories", force: :cascade do |t|
    t.integer "salary_per_day", default: 0
    t.integer "monthly_deduction", default: 0
    t.integer "total_deduction", default: 0
    t.integer "remaining_deduction", default: 0
    t.integer "work_hours", default: 0
    t.integer "total_salary", default: 0
    t.bigint "employee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_salary_histories_on_employee_id"
  end

  create_table "sallaries", force: :cascade do |t|
    t.string "employee_name"
    t.integer "date"
    t.string "position"
    t.integer "salary_per_day"
    t.integer "monthly_deduction"
    t.integer "total_deduction"
    t.integer "remaining_deduction"
    t.integer "total_salary"
    t.integer "total_salary_employee"
    t.integer "term_cash_receipt"
    t.integer "monthly_deduction_cash_receipt"
    t.datetime "cash_receipt_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "employee_id"
    t.index ["employee_id"], name: "index_sallaries_on_employee_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "stock_name"
    t.integer "current_stock", default: 0
    t.integer "in_stock", default: 0
    t.integer "out_stock", default: 0
    t.datetime "date_in"
    t.datetime "date_out"
    t.integer "remaining_stock"
    t.integer "total_stock", default: 0
    t.integer "price_stock", default: 0
    t.integer "total_price_stock", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "actor"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_toke_reset"
    t.string "status"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "absents", "employees", on_delete: :cascade
  add_foreign_key "cash_receipt_histories", "cash_receipts"
  add_foreign_key "cash_receipts", "employees", on_delete: :cascade
  add_foreign_key "employees", "positions", on_delete: :cascade
  add_foreign_key "salary_histories", "employees", on_delete: :cascade
end
