class AddFieldCurrentTimeToEmployee < ActiveRecord::Migration[6.0]
  def change
    add_column :employees,:current_active_month, :datetime, default: Time.now
  end
end
