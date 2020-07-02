class AddFullNameToUserData < ActiveRecord::Migration[6.0]
  def change
    add_column :user_datas,:full_name,:string
  end
end
