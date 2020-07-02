class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string  :employee_name
      t.string :email
      t.string :phone_number
      t.integer  :position
      t.integer  :status
      t.timestamps
    end
  end
end
