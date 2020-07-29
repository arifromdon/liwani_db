# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def reset_password
    @user = User.last
    UserMailer.reset_password(@user)
  end
end
