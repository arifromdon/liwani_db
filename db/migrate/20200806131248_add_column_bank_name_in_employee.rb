class AddColumnBankNameInEmployee < ActiveRecord::Migration[6.0]
  def change

    add_column :employees,:bank_name,:string

  end
end
