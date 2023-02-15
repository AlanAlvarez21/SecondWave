# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :photo

  validates :tittle, presence: true
  validates :price, presence: true
  validates :description, presence: true

  belongs_to :category
end
