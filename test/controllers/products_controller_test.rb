# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product', 3
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4))

    assert_response :success
    assert_select '.tittle', 'PS4'
  end

  test 'render a new product form' do
    get new_product_path

    assert_response :success
    assert_select 'form'
  end

  test 'render edit product form' do
    get edit_product_path(products(:ps4))

    assert_response :success
    assert_select 'form'
  end

  test 'allow to create new product' do
    post products_path, params: {
      product: {
        tittle: 'nintendo 64',
        description: 'perfectas condiciones',
        price: 45,
        category_id: categories(:videogames).id,
      },
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], I18n.t('products.create.created')
  end

  test 'dont allow to create new product with nill data' do
    post products_path, params: {
      product: {
        tittle: '',
        description: 'perfectas condiciones',
        price: 45,
      },
    }
    assert_response :unprocessable_entity
  end

  test 'allow to update a product' do
    patch product_path(products(:ps4)), params: {
      product: {
        price: 50,
      },
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], I18n.t('products.update.updated')
  end

  test 'dont allow to update a product with incorrect data' do
    patch product_path(products(:ps4)), params: {
      product: {
        price: nil,
      },
    }
    assert_response :unprocessable_entity
  end

  test 'can delete a product' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:ps4))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], I18n.t('products.destroy.deleted')
  end
end
