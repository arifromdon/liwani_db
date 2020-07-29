class AddReferencesEmployeeIdToCashReceipt < ActiveRecord::Migration[6.0]
  def change

    add_reference :cash_receipts,:employee,index: true

    remove_column :cash_receipts,:actor

    add_column :cash_receipts,:status,:boolean

  end
end
