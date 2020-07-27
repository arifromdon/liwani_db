class AddAllowanceToSallary < ActiveRecord::Migration[6.0]
  def change
    add_column :sallaries,:meal_allowance,:integer,default:0
    add_column :sallaries,:transport_allowance,:integer,default:0
    add_column :sallaries,:positional_allowance,:integer,default:0

    remove_column :add_allowances,:meal_allowances
    remove_column :add_allowances,:transport_allowances
    remove_column :add_allowances,:positional_allowances

  end
end
