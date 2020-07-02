class CreateAbsents < ActiveRecord::Migration[6.0]
  def change
    create_table :absents do |t|
      t.string  :employee_name
      t.integer :entry_hour
      t.integer :out_hour
      t.string  :position
      t.datetime  :date
      t.integer :status_absent
      t.integer :total_absent
      t.timestamps
    end
  end
end