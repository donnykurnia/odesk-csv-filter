class Product < ActiveRecord::Base

  validates :kind, presence: true
  validates :height, presence: true, numericality: { only_integer: true }

  # methods

  # class methods
  def self.bulk_insert(products_params)
    products_params[:kind].each_with_index do |kind, index|
      self.create(:kind => kind.strip,
                  :height => products_params[:height][index].strip,
                  :is_emergency_exit => products_params[:is_emergency_exit][index].strip,
                  :is_openable => products_params[:is_openable][index].strip)
    end
  end

end
