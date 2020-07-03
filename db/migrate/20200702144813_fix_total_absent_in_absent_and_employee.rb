class FixTotalAbsentInAbsentAndEmployee < ActiveRecord::Migration[6.0]
  def change
    add_column :employees,:total_absent_monthly,:integer
    add_column :employees,:total_absent,:integer

    remove_column :absents,:total_absent_monthly
    remove_column :absents,:total_absent
  end
end
