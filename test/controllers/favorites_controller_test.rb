# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @product = products(:snes)
    @switch = products(:switch)
  end

  test 'should create favorite' do
    post favorites_url(product_id: @product.id)
    assert_redirected_to product_path(@product)
  end

  test 'shoul create favorite' do
    assert_difference('Favorite.count', 1) do
      post favorite_url(product_id: @product.id)
    end

    assert_redirected_to product_path(@product)
  end

  test 'shoul unfavorite' do
    assert_difference('Favorite.count', -1) do
      delete favorite_url(@switch.id)
    end

    assert_redirected_to product_path(@switch)
  end
end
