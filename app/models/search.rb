class Search < ActiveRecord::Base
  # associations
  has_many :connections, class_name: "Search",
                          foreign_key: "parent_id",
                          dependent: :destroy
  accepts_nested_attributes_for :connections, allow_destroy: true
  belongs_to :parent, class_name: "Search"
  has_many :search_results
end
