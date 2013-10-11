class SearchResult < ActiveRecord::Base
  # associations
  belongs_to :search
  belongs_to :product
end
