class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailers.user_mailer.subject_mail_signup")
  end

  def password_reset user
    @user = user
    mail to: user.email,
    subject: t("mailers.user_mailer.subject_mail_password_reset")
  end
end
