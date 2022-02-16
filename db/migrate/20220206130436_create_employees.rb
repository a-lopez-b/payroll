class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.integer :code, null: false 
      t.string :first_name, null:false, limit: 50
      t.string :last_name, limit: 100
      t.string :ssn, limit:11
      t.string :tax_id, limit:13
      t.string :payment_period, null:false, limit:1, defualt:'Q'
      t.string :job, limit:150
      t.boolean :active, null:false, defualt:1

      t.timestamps
    end
  end
end
