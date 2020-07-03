class AddChangeFieldOnAbsent < ActiveRecord::Migration[6.0]
  def change
    remove_column :absents,:entry_hour
    remove_column :absents,:out_hour

    add_column :absents,:entry_hour,:datetime
    add_column :absents,:out_hour,:datetime
  end
end
