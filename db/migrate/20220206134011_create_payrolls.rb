class CreatePayrolls < ActiveRecord::Migration[7.0]
  def change
    create_table :payrolls do |t|
      t.decimal :tax_amount, null:false, default:0
      t.decimal :ssn_amount, null:false, default:0
      t.decimal :net_amount, null:false, default:0
      t.boolean :status, null:false, default:1
      t.references :employee, null: false, foreign_key: true
      t.references :payroll_period, null: false, foreign_key: true

      t.timestamps
    end
  end
end
