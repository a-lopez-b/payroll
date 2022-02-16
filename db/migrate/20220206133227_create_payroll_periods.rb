class CreatePayrollPeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :payroll_periods do |t|
      t.integer :year, null:false
      t.integer :month, null:false
      t.integer :consecutive, null:false
      t.date :start_date, null:false
      t.date :end_date, null:false
      t.string :payroll_period, limit:1, null:false
      t.decimal :tax_amount, precision:18, scale:2
      t.decimal :ssn_amount, precision:18, scale:2
      t.decimal :net_amount, precision:18, scale:2
      t.integer :status, default:0
      t.integer :application_status, default:0
      t.boolean :active, null:false, default:1

      t.timestamps
    end
  end
end
