class Product < ActiveRecord::Base

  # methods
  def csv_headers
    ["Kind", "Height", "Emergency exit", "Openable"]
  end

  # class methods
  def self.search(search_params)
    products = all
    # products = products.where("products.title like :search OR products.description like :search", { search: "%" + search_params + "%" }) unless search_params.blank?
    products
  end

end
