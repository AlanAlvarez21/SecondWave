# frozen_string_literal: true

class UserMailerPreview < ActionMailer::Preview
  # preview: http://localhost:3000/rails/mailers/user/welcome
  def welcome
    binding.pry
    UserMailer.with(user: User.last).welcome
  end
end
