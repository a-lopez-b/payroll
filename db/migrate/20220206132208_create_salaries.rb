class CreateSalaries < ActiveRecord::Migration[7.0]
  def change
    create_table :salaries do |t|
      t.datetime :date, null:false
      t.string :salary_type, null:false
      t.decimal :sdn, null:false, precision: 10, scale:2
      t.decimal :sdi, null:false, precision: 10, scale:2
      t.boolean :active, null:false, default:1
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
