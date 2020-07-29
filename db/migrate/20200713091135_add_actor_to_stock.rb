class AddActorToStock < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks,:actor,:string
  end
end
