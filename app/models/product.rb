class Product < ActiveRecord::Base

  validates :kind, presence: true
  validates :height, presence: true, numericality: { only_integer: true }

  # methods

  # class methods
  def self.search(search_params)
    products = all
    # products = products.where("products.title like :search OR products.description like :search", { search: "%" + search_params + "%" }) unless search_params.blank?
    products
  end

  def self.bulk_insert(products_params)
  end

end
