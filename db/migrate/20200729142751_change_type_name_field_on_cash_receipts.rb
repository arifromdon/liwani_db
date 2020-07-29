class ChangeTypeNameFieldOnCashReceipts < ActiveRecord::Migration[6.0]
  def change
  	rename_column :cash_receipts, :type, :deduce_type
  end
end
