# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @user = users(:alan)
  end

  test 'should get show' do
    get user_url(@user.username)
    assert_response :success
  end
end
