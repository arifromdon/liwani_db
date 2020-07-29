class AddEmployeeToPosition < ActiveRecord::Migration[6.0]
  def change

    add_reference :employees,:position,index: true

  end
end
