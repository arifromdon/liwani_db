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

ActiveRecord::Schema.define(version: 2020_06_30_130133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absents", force: :cascade do |t|
    t.string "employee_name"
    t.integer "entry_hour"
    t.integer "out_hour"
    t.string "position"
    t.datetime "date"
    t.boolean "status_absent"
    t.integer "total_absent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_datas_id"
    t.index ["user_datas_id"], name: "index_absents_on_user_datas_id"
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
    t.bigint "user_datas_id"
    t.index ["user_datas_id"], name: "index_sallaries_on_user_datas_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "stock_name"
    t.integer "current_stock"
    t.integer "in_stock"
    t.integer "out_stock"
    t.datetime "date_in"
    t.datetime "date_out"
    t.integer "remaining_stock"
    t.integer "total_stock"
    t.integer "price_stock"
    t.integer "total_price_stock"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_datas_id"
    t.index ["user_datas_id"], name: "index_stocks_on_user_datas_id"
  end

  create_table "user_datas", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "birthdate"
    t.integer "phone_number"
    t.string "position"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.string "full_name"
    t.index ["user_id"], name: "index_user_datas_on_user_id"
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

  add_foreign_key "absents", "user_datas", column: "user_datas_id"
  add_foreign_key "sallaries", "user_datas", column: "user_datas_id"
  add_foreign_key "stocks", "user_datas", column: "user_datas_id"
  add_foreign_key "user_datas", "users"
end
