# frozen_string_literal: true

# Products Controller
class ProductsController < ApplicationController
  skip_before_action :protect_pages, only: %i[index show]

  def index
    @categories = Category.all.order(name: :asc).load_async
    @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items: 12)
  end

  def show
    product
  end

  def new
    @product = Product.new
  end

  def edit
    authorize! product
    product
  end

  def create
    # @product = Current.user.products.new(product_params) replaced by belongs_to :user, default: -> { Current.user }
    # in products model

    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! product
    product

    if @product.update(product_params)
      @product.broadcast
      redirect_to products_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! product
    product
    @product.destroy
    # :see_other -> indica un  303 redirect que no enlaza al producto en el que estabamos
    redirect_to products_path, notice: t('.deleted'), status: :see_other
  end

  private

  def product_params_index
    params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page, :favorites, :locale, :user_id)
  end

  def product_params
    @product_params = params.require(:product).permit(:title, :description, :price, :photo, :category_id, :user,
                                                      :locale)
  end

  def product
    @product ||= Product.find(params[:id])
  end
end
