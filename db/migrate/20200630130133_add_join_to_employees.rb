class AddJoinToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees,:join,:datetime
  end
end
