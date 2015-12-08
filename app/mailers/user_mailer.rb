
class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    # attachments.inline['airgabion-logo-03-ece4cd2c0c8a4944b2f5b47cae9b71b36641d553937a73248cbf4a4e5af5c645.png'] = File.read('http://airgabion.com/assets/airgabion-logo-03-ece4cd2c0c8a4944b2f5b47cae9b71b36641d553937a73248cbf4a4e5af5c645.png')
    mail(to: @user.email, subject: 'Welcome to beerandbed!')
    # This will render a view in `app/views/user_mailer`!
  end
end
