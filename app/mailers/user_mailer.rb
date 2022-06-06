class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: @user.email, subject: "サイトへの登録ありがとうございます！"
    # return mail（メールオブジェクトが返却される）
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end
