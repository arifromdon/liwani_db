class CreateCashReceiptHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :cash_receipt_histories do |t|

      t.references :cash_receipt, index: true, foreign_key: true
      t.integer    :total_deduce
      t.integer    :remaining_deduction

      t.timestamps
    end
  end
end
