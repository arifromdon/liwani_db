class CreateDeductions < ActiveRecord::Migration[6.0]
  def change
    create_table :deductions do |t|
      t.references :employees
      t.float      :total_deduction
      t.float      :remaining_deduction
      t.integer    :deduction_length
      t.integer    :status, default: 0

      t.timestamps
    end
  end
end
