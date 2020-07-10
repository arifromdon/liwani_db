class AddDefaultToStock < ActiveRecord::Migration[6.0]
  def change

    change_column :stocks,:current_stock,:integer,default:0
    change_column :stocks,:in_stock,:integer,default:0
    change_column :stocks,:out_stock,:integer,default:0
    change_column :stocks,:total_stock,:integer,default:0
    change_column :stocks,:price_stock,:integer,default:0
    change_column :stocks,:total_price_stock,:integer,default:0

  end
end
