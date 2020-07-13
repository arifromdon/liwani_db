class AddColumnWorkHoursToEmployee < ActiveRecord::Migration[6.0]
  def change
    add_column :employees,:total_work_hour,:integer,default:0
  end
end
