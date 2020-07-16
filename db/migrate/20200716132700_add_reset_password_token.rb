class AddResetPasswordToken < ActiveRecord::Migration[6.0]
  def change
    add_column :users,:password_toke_reset,:string
  end
end
