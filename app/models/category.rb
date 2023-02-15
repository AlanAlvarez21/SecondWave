# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_exception

  def initialize(params={})
    super(params)
  end
end
