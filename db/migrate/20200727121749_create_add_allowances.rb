class CreateAddAllowances < ActiveRecord::Migration[6.0]
  def change
    create_table :add_allowances do |t|
      t.integer  :meal_allowances,default:0
      t.integer  :transport_allowances,default:0
      t.integer  :positional_allowances,default:0
      t.timestamps
    end
  end
end
