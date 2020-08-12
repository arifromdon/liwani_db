class AddColumnAtmInEmployee < ActiveRecord::Migration[6.0]
  def change

    add_column :employees,:id_bank,:integer,default:0

  end
end
