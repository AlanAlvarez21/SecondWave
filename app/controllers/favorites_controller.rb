# frozen_string_literal: true

# Favorites Controller
class FavoritesController < ApplicationController
  def index; end

  def create
    # Favorite.create(product: product, user: Current.user) es lo mismo que la siguiente línea pero aprovechando el scoping
    # product.favorites.create(user: Current.user)
    product.favorite!
    respond_to do |format|
      format.html do
        redirect_to product_path(product)
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('favorite', partial: 'products/favorite',
                                                              locals: { product: product })
      end
    end
  end

  def destroy
    # product.favorites.find_by(user: Current.user).destroy
    product.unfavorite!
    respond_to do |format|
      format.html do
        redirect_to product_path(product), status: :see_other
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('favorite', partial: 'products/favorite',
                                                              locals: { product: product })
      end
    end
  end

  private

  def product
    @product ||= Product.find(params[:product_id])
  end
end
