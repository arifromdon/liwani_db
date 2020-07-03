class AddFieldToAbsent < ActiveRecord::Migration[6.0]
  def change
    add_column :absents,:total_absent_monthly,:integer
    add_column :absents,:active,:integer

    remove_column :absents,:employee_name
    remove_column :absents,:position

    add_reference :absents,:employee,index:true
  end
end
