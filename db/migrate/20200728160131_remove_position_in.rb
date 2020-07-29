class RemovePositionIn < ActiveRecord::Migration[6.0]
  def change

    remove_column :employees,:position

  end
end
