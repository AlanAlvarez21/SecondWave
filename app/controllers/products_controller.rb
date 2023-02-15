# frozen_string_literal: true

# Products Controller
class ProductsController < ApplicationController
  def index
    @categories = Category.all.order(name: :asc).load_async
    @products = Product.all.with_attached_photo.order(created_at: :desc).load_async
    # if category params is in the query params find the product by id category
    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
    @products = @products.where('price >= ?', params[:min_price]) if params[:min_price].present?
    @products = @products.where('price <= ?', params[:max_price]) if params[:max_price].present?
    @products = @products.search_full_text(params[:query_text]) if params[:query_text].present?
  end

  def show
    product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    product
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

  def product_params
    params.require(:product).permit(:tittle, :description, :price, :photo, :category_id)
  end
end
