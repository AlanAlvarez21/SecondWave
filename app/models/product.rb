class Product < ApplicationRecord
  validates :tittle, presence: true
  validates :price, presence: true
  validates :description, presence: true
end
