# frozen_string_literal: true

class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_full_text, against: {
    title: 'A',
    description: 'B'
  }

  ORDER_BY = {
    newest: 'created_at DESC',
    expensive: 'price DESC',
    chepeast: 'price ASC'
  }.freeze

  has_one_attached :photo

  validates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true

  belongs_to :category

  #assigns the current user by default to the product
  belongs_to :user, default: -> { Current.user }

  def owner?
    user_id == Current.user&.id
  end
end
