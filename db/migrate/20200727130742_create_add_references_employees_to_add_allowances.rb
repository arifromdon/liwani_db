class CreateAddReferencesEmployeesToAddAllowances < ActiveRecord::Migration[6.0]
  def change

      add_reference :add_allowances,:employee,index: true

  end
end
