# frozen_string_literal: true

# Categories Controller
class CategoriesController < ApplicationController
  def index
    @categories = Category.all.order(name: :asc)
  end

  def new
    @category = Category.new
  end

  def edit
    category
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      respond_to do |format|
        format.html { redirect_to categories_url, notice: t('.created') }
      end
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  def update
    if category.update(category_params)
      respond_to do |format|
        format.html { redirect_to categories_url, notice: t('.updated') }
      end
    else
      format.html { render :edit, status: :unprocessable_entity }
    end
  end

  def destroy
    category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: t('.destroyed') }
    end
  end

  private

  def category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name)
  end
end
