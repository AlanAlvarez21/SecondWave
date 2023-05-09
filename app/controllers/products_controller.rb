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
    product
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    product

    if @product.update(product_params)
      redirect_to products_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product
    @product.destroy
    # :see_other -> indica un  303 redirect que no enlaza al producto en el que estabamos
    redirect_to products_path, notice: t('.deleted'), status: :see_other
  end

  def product
    @product = Product.find(params[:id])
  end

  private

  def product_params_index
    params.permit(:category_id, :min_price, :max_price, :query_text, :order_by)
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end
end
