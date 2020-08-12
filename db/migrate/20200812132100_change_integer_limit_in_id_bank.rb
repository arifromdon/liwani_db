class ChangeIntegerLimitInIdBank < ActiveRecord::Migration[6.0]
  def change

    change_column :employees,:id_bank,:string

    add_column :employees,:user_bank,:string

  end
end
