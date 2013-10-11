class AddSortToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :sort_by, :string
    add_column :searches, :sort_direction, :string
  end
end
