class AddDefaultToTotalsEmployee < ActiveRecord::Migration[6.0]
  def change

    change_column :employees,:total_absent_monthly,:integer,default:0
    change_column :employees,:total_absent,:integer,default:0

  end
end
