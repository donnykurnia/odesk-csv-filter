class Search < OpenStruct
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  def initialize(*args)
    super
  end

  def persisted?
    false
  end

end