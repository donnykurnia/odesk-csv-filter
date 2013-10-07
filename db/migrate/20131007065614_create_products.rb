class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :kind
      t.integer :height
      t.boolean :is_emergency_exit
      t.boolean :is_openable

      t.timestamps
    end
  end
end
