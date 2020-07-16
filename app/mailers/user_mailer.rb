class UserMailer < ActionMailer::Base

  default from: 'Admin Liwani'
  layout 'mailer'

  def reset_password(user)

    @user = user
    @token = Base64.encode64(@user.password_toke_reset)

    mail(to:@user.email, subject: "Reset Password")

  end

end
