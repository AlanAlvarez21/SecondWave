# frozen_string_literal: true

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @category = categories(:clothes)
  end

  test 'should get index list of categories' do
    get categories_url

    assert_response :success
  end

  test 'should get new' do
    get new_category_url

    assert_response :success
  end

  test 'should create category' do
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: @category.name } }
    end

    assert_redirected_to categories_url
  end
end
