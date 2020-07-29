class CreateCashReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :cash_receipts do |t|
      t.string  :actor
      t.integer :total_cash_receipt,default:0
      t.integer :monthly_deduction,default:0
      t.integer :cash_receipt_term,default:0
      t.integer :rest_receipt_term,default:0
      t.timestamps
    end
  end
end
