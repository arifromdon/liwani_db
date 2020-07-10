class AddReferencesEmployeesToSalary < ActiveRecord::Migration[6.0]
  def change

    add_reference :sallaries,:employee,index: true

  end
end
