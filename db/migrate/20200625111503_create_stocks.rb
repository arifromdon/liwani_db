class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string  :stock_name
      t.integer :stock
      t.integer :price_stock
      t.integer :in_stock
      t.integer :out_stock
      t.integer :total_stock
      t.integer :total_price_stock
      t.timestamps
    end
  end
end