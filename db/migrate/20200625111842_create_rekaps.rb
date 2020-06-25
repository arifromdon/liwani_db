class CreateRekaps < ActiveRecord::Migration[6.0]
  def change
    create_table :rekaps do |t|
      t.string  :expanse_name
      t.integer :date
      t.integer :total_expenditure
      t.references  :stocks
      t.references  :sallaries
      t.timestamps
    end
  end
end
