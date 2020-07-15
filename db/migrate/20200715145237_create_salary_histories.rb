class CreateSalaryHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :salary_histories do |t|
      t.integer :salary_per_day,default:0
      t.integer :monthly_deduction,default:0
      t.integer :total_deduction,default:0
      t.integer :remaining_deduction,default:0
      t.integer :work_hours, default:0
      t.integer :total_salary,default:0
      t.references :employee

      t.timestamps
    end
  end
end
