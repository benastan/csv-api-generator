class Resource < ActiveRecord::Base
  belongs_to :service
  has_many :resource_columns
  has_attached_file :csv, content_type: { content_type: 'text/csv' }

  after_save do
    if csv_file_name_changed? && csv_file_name_was.nil?
      require 'csv'
      csv = CSV.new(File.read(self.csv.path))
      headers = csv.headers || csv.shift
      headers.each_with_index do |header, index|
        resource_columns.create(name: header, index: index)
      end
      csv.each_with_index do |row, row_index|
        resource_column = resource_columns[row_index]
        row.each_with_index do |value, value_index|
          resource_column.resource_column_values.create(index: row_index, value: value)
        end
      end
    end
  end
end
