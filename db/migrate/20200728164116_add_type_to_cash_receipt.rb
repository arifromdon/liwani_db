class AddTypeToCashReceipt < ActiveRecord::Migration[6.0]
  def change

    add_column :cash_receipts,:type,:integer,default:0

  end
end
