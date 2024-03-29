# frozen_string_literal: true

require 'test_helper'

module Authentication
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:alan)
    end

    test 'should get new' do
      get new_session_url

      assert_response :success
    end

    test 'should login an user by email' do
      assert_difference('User.count') do
        post sessions_url, params: {  login: @user.email, password: 'test' }
      end

      assert_redirected_to products_url
    end

    test 'should login an user by username' do
      assert_difference('User.count') do
        post sessions_url, params: {  login: @user.username, password: 'test' }
      end

      assert_redirected_to products_url
    end

    test 'should logout' do
      login

      delete session_url_to products_url
      assert_equal flash[:notice], 'Usuario deslogueado'
    end
  end
end
