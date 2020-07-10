class ChangeColumnStatusAbsentToInteger < ActiveRecord::Migration[6.0]
  def change
    change_column :absents,:status_absent,:integer, using: 'status_absent::integer'
  end
end
