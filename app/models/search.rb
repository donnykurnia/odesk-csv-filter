class Search < ActiveRecord::Base
  # associations
  has_many :connections, class_name: "Search",
                          foreign_key: "parent_id",
                          dependent: :destroy
  belongs_to :parent, class_name: "Search"
  has_many :search_results
end
