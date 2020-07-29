class CreateBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :banks do |t|
      t.integer :bank_account_number,default:0
      t.string :bank_name
      t.string :owner
      t.timestamps
    end
  end
end
