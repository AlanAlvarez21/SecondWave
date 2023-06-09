# frozen_string_literal: true

require 'test_helper'

class UserMailerTest < ApplicationMailer::TestCase
  def setup
    @user = User.last
  end

  test 'welcome' do
    mail = UserMailer.with(user: @user).welcome
    assert_equal 'welcome', mail.subject
  end
end
