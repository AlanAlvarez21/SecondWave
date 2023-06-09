# frozen_string_literal: true

# User mailer
class UserMailer < ApplicationMailer
  def welcome
    @user = params&.[](:user) || User.last
    @username = @user.username
    mail to: @user.email
  end
end
