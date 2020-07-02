class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string  :stock_name
      t.integer :current_stock
      t.integer :in_stock
      t.integer :out_stock
      t.datetime  :date_in
      t.datetime  :date_out
      t.integer :remaining_stock
      t.integer :total_stock
      t.integer :price_stock
      t.integer :total_price_stock
      t.timestamps
    end
  end
end