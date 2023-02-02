# frozen_string_literal: true

# Products Controller
class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: I18n.t('created_product')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path, notice: I18n.t('updated_product')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    # :see_other -> indica un  303 redirect que no enlaza al producto en el que estabamos
    redirect_to products_path, notice: I18n.t('deleted_product'), status: :see_other
  end

private

  def product_params
    params.require(:product).permit(:tittle, :description, :price, :photo)
  end
end
