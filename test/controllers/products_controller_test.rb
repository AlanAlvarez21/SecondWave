require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

    test 'render a list of products' do
        get products_path

        assert_response :success
        assert_select '.product', 2
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

    test 'allow to create new product' do
        post products_path, params: {
            product: {
                tittle: 'nintendo 64',
                description: 'perfectas condiciones',
                price: 45,
            }
         }
         assert_redirected_to products_path
    end

    test 'dont allow to create new product with nill data' do
        post products_path, params: {
            product: {
                tittle: '',
                description: 'perfectas condiciones',
                price: 45,
            }
         }
         assert_response :unprocessable_entity
    end
end