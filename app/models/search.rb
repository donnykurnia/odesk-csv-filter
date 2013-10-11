class Search < ActiveRecord::Base
  # associations
  has_many :connections, class_name: "Search",
                          foreign_key: "parent_id",
                          dependent: :destroy
  accepts_nested_attributes_for :connections, allow_destroy: true
  belongs_to :parent, class_name: "Search"
  has_many :search_results

  default_scope -> { order("id asc") }

  # methods
  def value_key
    "value_#{self.id}"
  end

  def condition_str
    str = "#{self.pre_condition} #{self.field}"
    if self.field.match(/^is.*/).nil?
      str += " #{self.comparison} :#{self.value_key}"
    end
    str
  end

  def value_hash
    hash = {}
    if self.field.match(/^is.*/).nil?
      hash.merge!({:"#{self.value_key}" => self.value})
    end
    hash
  end

  def condition_array
    all_condition_str = self.condition_str
    all_value_hash = self.value_hash
    connections.each do |connection|
      all_condition_str += " #{connection.connector} #{connection.condition_str}"
      all_value_hash.merge!(connection.value_hash)
    end
    [all_condition_str, all_value_hash]
  end

  def order_str
    "#{self.sort_by} #{self.sort_direction}"
  end

end
