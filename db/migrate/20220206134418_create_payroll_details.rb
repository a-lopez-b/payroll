class CreatePayrollDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :payroll_details do |t|
      t.decimal :quantity, null:false, precision:5, scale: 2
      t.integer :concept_type, null:false
      t.decimal :taxed, null:false, precision:18, scale: 2
      t.decimal :exempt, null:false, precision:18, scale: 2
      t.decimal :retention, null:false, precision:18, scale: 2
      t.references :payroll, null: false, foreign_key: true
      t.references :concept, null: false, foreign_key: true


      t.timestamps
    end
  end
end
