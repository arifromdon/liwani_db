class RenameColumnEmployeeOnSalaryHistory < ActiveRecord::Migration[6.0]
  def change
    rename_column :salary_histories,:employees_id,:employee_id
  end
end
