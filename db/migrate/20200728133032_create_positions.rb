class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions do |t|
      t.string  :position_name
      t.integer :positional_allowance,default:0
      t.integer :transportation_allowance,default:0
      t.integer :meal_allowances,default:0
      t.references :employees
      t.timestamps
    end
  end
end
