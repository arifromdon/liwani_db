class DeleteEmployeeIdInPosition < ActiveRecord::Migration[6.0]
  def change

    remove_column :positions,:employee_id

  end
end
