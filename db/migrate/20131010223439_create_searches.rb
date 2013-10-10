class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :field
      t.string :pre_condition
      t.string :comparison
      t.string :value
      t.string :connector
      t.integer :parent_id

      t.timestamps
    end
    add_index :searches, :parent_id
    add_foreign_key :searches, :searches, column: :parent_id, dependent: :delete
  end
end
