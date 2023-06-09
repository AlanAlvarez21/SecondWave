# frozen_string_literal: true

# Category component logic
class CategoryComponent < ViewComponent::Base
  attr_reader :category

  def initialize(category: nil) 
    @category = category
  end

  def title
    category ? @category.name : t('.all')
  end

  def link
    category ? products_path(category_id: category.id) : products_path
  end

  def active?
    return true if !category && !params[:category_id]

    category&.id == params[:category_rrid].to_i
  end

  def background
    active? ? 'bg-gray-300' : 'bg-white'
  end

  def classes
    "category px-4 py-2 text-gray-600 rounded-2xl drop-shadow-sm hover:bg-gray-300 #{background}"
  end
end
