# frozen_string_literal: true

class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_full_text, against: {
    tittle: 'A',
    description: 'B',
  }
  has_one_attached :photo
  validates :tittle, presence: true
  validates :price, presence: true
  validates :description, presence: true
  belongs_to :category
end
