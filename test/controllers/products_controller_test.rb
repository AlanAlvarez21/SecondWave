# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product', 12
  end

  test 'render a list of products filtered by category' do
    get products_path(category_id: categories(:computers))

    assert_response :success
    assert_select '.product', 5
  end

  test 'filter a list of products filtered by min_price and max_price' do
    get products_path(min_price: 160, max_price: 300)

    assert_response :success
    assert_select '.product', 4
    assert_select 'h3', 'Nintendo Switch'
  end

  test 'filter a list of products filtered by query_text' do
    get products_path(query_text: 'Macbook')

    assert_response :success
    assert_select '.product', 1
    assert_select 'h3', 'Macbook Air'
  end

  test 'order a list of products filtered by price ASC ' do
    get products_path(order_by: 'expensive')

    assert_response :success
    assert_select '.product', 12
    assert_select '.products .product:first-child h3', 'Seat Panda clásico'
  end

  test 'order a list of products filtered by price DESC ' do
    get products_path(order_by: 'chepeast')

    assert_response :success
    assert_select '.product', 12
    assert_select '.products .product:first-child h3', 'El hobbit'
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4))

    assert_response :success
    assert_select '.title', 'PS4 Fat'
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
        title: 'nintendo 64',
        description: 'perfectas condiciones',
        price: 45,
        category_id: categories(:videogames).id
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], I18n.t('products.create.created')
  end

  test 'dont allow to create new product with nill data' do
    post products_path, params: {
      product: {
        title: '',
        description: 'perfectas condiciones',
        price: 45
      }
    }
    assert_response :unprocessable_entity
  end

  test 'allow to update a product' do
    patch product_path(products(:ps4)), params: {
      product: {
        price: 50
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], I18n.t('products.update.updated')
  end

  test 'dont allow to update a product with incorrect data' do
    patch product_path(products(:ps4)), params: {
      product: {
        price: nil
      }
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
