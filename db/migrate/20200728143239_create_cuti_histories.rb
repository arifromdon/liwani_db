class CreateCutiHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :cuti_histories do |t|
      t.references  :employee, index:true
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.integer :sisa,default:0
      t.text :description
      t.timestamps
    end
  end
end
