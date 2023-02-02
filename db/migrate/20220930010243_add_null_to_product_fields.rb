# AddNullToProductFields migration to validate these products to not be false
class AddNullToProductFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :tittle, false
    change_column_null :products, :description, false
    change_column_null :products, :price, false
  end
end
