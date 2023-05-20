# frozen_string_literal: true

# Favorites Controller
class FavoritesController < ApplicationController
  def create
    # Favorite.create(product: product, user: Current.user) es lo mismo que la siguiente línea pero aprovechando el scoping
    # product.favorites.create(user: Current.user)
    product.favorite!
    redirect_to product_path(product)
  end

  def destroy
    # product.favorites.find_by(user: Current.user).destroy
    product.unfavorite!
    redirect_to product_path(product), status: :see_other
  end

  private

  def product
    @product ||= Product.find(params[:product_id])
  end
end
