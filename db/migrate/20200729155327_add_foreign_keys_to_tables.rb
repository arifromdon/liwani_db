class AddForeignKeysToTables < ActiveRecord::Migration[6.0]
  DOWNTIME = false

  def up
    add_foreign_key :absents, :employees, on_delete: :cascade, validate: false
    add_foreign_key :salary_histories, :employees, on_delete: :cascade, validate: false
    add_foreign_key :cash_receipts, :employees, on_delete: :cascade, validate: false
    add_foreign_key :employees, :positions, on_delete: :cascade, validate: false
  end

  def down
    remove_foreign_key_if_exists :absents, column: :employee_id
    remove_foreign_key_if_exists :salary_histories, column: :employee_id
    remove_foreign_key_if_exists :cash_receipts, column: :employee_id
    remove_foreign_key_if_exists :employees, column: :position_id
  end
end
