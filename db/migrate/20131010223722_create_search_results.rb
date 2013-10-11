class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.references :search, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
