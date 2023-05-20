# frozen_string_literal: true

class AddProductsToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :user, null: false, foreign_key: true
  end
end
