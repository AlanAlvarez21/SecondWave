# frozen_string_literal: true

class Product < ApplicationRecord
  include PgSearch::Model
  include Favoritable

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
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true

  belongs_to :category

  # assigns the current user by default to the product
  belongs_to :user, default: -> { Current.user }

  def owner?
    user_id == Current.user&.id
  end

  def broadcast
    broadcast_replace_to self, partial: 'products/product_details', locals: { product: self }
  end
end
