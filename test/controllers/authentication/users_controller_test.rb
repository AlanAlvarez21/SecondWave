# frozen_string_literal: true

require 'test_helper'

module Authentication
  class UsersControllerTest < ActionDispatch::IntegrationTest
    test 'should get new' do
      get new_user_url

      assert_response :success
    end

    test 'should create new user' do
      assert_difference('User.count') do
        post users_url, params: { user: { email: 'test@example.com', username: 'Alan', password: 123_456_789_0 } }
      end

      assert_redirected_to products_url
    end
  end
end
