class CreateSallaries < ActiveRecord::Migration[6.0]
  def change
    create_table :sallaries do |t|
      t.string  :employee_name
      t.integer :date
      t.string  :position
      t.integer :salary
      t.integer :cutting
      t.integer :subtotal_salary
      t.integer :total_salary
      t.timestamps
    end
  end
end
