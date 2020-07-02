class CreateSallaries < ActiveRecord::Migration[6.0]
  def change
    create_table :sallaries do |t|
      t.string  :employee_name
      t.integer :date
      t.string  :position
      t.integer :salary_per_day
      t.integer :monthly_deduction
      t.integer :total_deduction
      t.integer :remaining_deduction
      t.integer :total_salary
      t.integer :total_salary_employee
      t.integer :term_cash_receipt
      t.integer :monthly_deduction_cash_receipt
      t.datetime :cash_receipt_date
      t.timestamps
    end
  end
end
