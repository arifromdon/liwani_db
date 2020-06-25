class CreateUserData < ActiveRecord::Migration[6.0]
  def change
    create_table :user_datas do |t|
      t.string  :username
      t.string  :email
      t.datetime  :birthdate
      t.integer :phone_number
      t.timestamps
    end
  end
end