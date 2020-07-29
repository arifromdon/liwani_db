class AddSalaryTo < ActiveRecord::Migration[6.0]
  def change

    add_column :positions,:salary,:integer,default:0

    remove_column :positions,:employees_id

    add_reference :positions,:employee,index: true

  end
end
