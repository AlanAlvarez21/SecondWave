# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @product = products(:snes)
  end

  test 'should create favorite' do
    post favorites_url(product_id: @product.id)
    assert_redirected_to product_path(@product)
  end

  test 'shoul create favorite' do
    assert_difference('Favorite.count', 1) do
      post favorites_url(product_id: @product.id)
    end

    assert_redirected_to product_path(@product)
  end
end
