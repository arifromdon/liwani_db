class CreateAbsents < ActiveRecord::Migration[6.0]
  def change
    create_table :absents do |t|
      t.string  :employee_name
      t.integer :entry_hour
      t.integer :out_hour
      t.boolean :status
      t.integer :date
      t.timestamps
    end
  end
end
