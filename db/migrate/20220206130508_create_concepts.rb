class CreateConcepts < ActiveRecord::Migration[7.0]
  def change
    create_table :concepts do |t|
      t.integer :code, null:false
      t.string :name, null:false, limit:150
      t.integer :concept_type, null:false
      t.boolean :active, null:false, default:1

      t.timestamps
    end
  end
end
