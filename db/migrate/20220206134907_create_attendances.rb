class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.date :date, null:false
      t.decimal :sdn, null:false
      t.decimal :sdi, null:false
      t.integer :status, null:false
      t.references :employee, foreign_key: true
      t.references :payroll_period, foreign_key: true
      t.references :payroll, foreign_key: true
      t.references :payroll_detail, foreign_key: true

      t.timestamps
    end
  end
end
