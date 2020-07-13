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

ActiveRecord::Schema.define(version: 2020_07_13_103319) do

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

  create_table "employees", force: :cascade do |t|
    t.string "employee_name"
    t.string "email"
    t.string "phone_number"
    t.integer "position"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "join"
    t.integer "total_absent_monthly", default: 0
    t.integer "total_absent", default: 0
    t.integer "total_work_hour", default: 0
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
