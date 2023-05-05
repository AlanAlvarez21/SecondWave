# frozen_string_literal: true

class ChangeProductsTittle < ActiveRecord::Migration[7.0]
  def change
    change_table :products do |t|
      t.rename :tittle, :title
    end
  end
end
