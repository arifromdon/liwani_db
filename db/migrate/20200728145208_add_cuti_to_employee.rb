class AddCutiToEmployee < ActiveRecord::Migration[6.0]
  def change

    add_column :employees,:leave_rasio,:integer,default:0

  end
end
