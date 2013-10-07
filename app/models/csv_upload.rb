class CsvUpload < OpenStruct
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  # validation
  validates :csv_file, presence: true

  # methods
  def initialize(*args)
    super
  end

  def persisted?
    false
  end

  # class methods
  def self.csv_headers
    ["Kind", "Height", "Emergency exit", "Openable"]
  end

  def self.import(csv_params)
    require 'csv'

    result = self.new(csv_params)
    result.products = []

    # filter valid content types
    valid_content_types = ["application/vnd.ms-excel", "text/plain", "text/csv"]
    if ! result.csv_file.blank? && valid_content_types.include?(result.csv_file.content_type)

      # clean up csv file
      # tmp_file = "#{Rails.root}/tmp/uploads/clean_csv"
      # system("tr -d '\n' < " + result.csv_file.path + "> "+ tmp_file)

      # read csv file
      # temp_csv_rows = CSV.read(tmp_file, :headers => true, :col_sep => ';')
      # csv_rows = temp_csv_rows.size == 0 ? CSV.read(result.csv_file.path, :headers => true, :col_sep => ';') : temp_csv_rows
      csv_rows = CSV.read(result.csv_file.path, :headers => true, :col_sep => ';')

      #header check
      headers = csv_rows.headers.map{|header| header.split(" ").join(" ") rescue ""}
      headers.each do |header|
        result.errors[:base] << "wrong headers - #{header} is not recognized" unless self.csv_headers.include?(header)
      end

      unless result.errors[:base].blank?
        return result
      end

      unless headers == self.csv_headers
        result.errors[:base] << "wrong headers - headers is not in good order"
        return result
      end

      csv_rows.each_with_index do |row, idx|
        product = Product.new(:kind => row[0].strip,
                              :height => row[1].strip,
                              :is_emergency_exit => (row[2].strip == 'True'),
                              :is_openable => (row[3].strip == 'True'))
        if product.valid?
          result.products << product
        else
          result.errors[:base] << "Error in row #{idx+1}: #{product.errors.full_messages.join(", ")}"
        end
      end

      result
    end
  end

end