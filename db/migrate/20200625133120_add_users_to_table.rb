class AddUsersToTable < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_datas, :user, foreign_key: true
    add_reference :stocks, :user_data, foreign_key: true
    add_reference :absents, :user_data, foreign_key: true
    add_reference :sallaries, :user_data, foreign_key: true
  end
end
