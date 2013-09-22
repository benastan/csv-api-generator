class Resource < ActiveRecord::Base
  belongs_to :service
  has_many :columns, class_name: :ResourceColumn
  has_many :rows, through: :columns
  has_attached_file :csv, content_type: { content_type: 'text/csv' }

  validates :name, presence: true

  def records
    columns.collect(&:values).flatten.group_by do|row|
      row[:index]
    end.values.collect do |ary|
      row = ary.collect(&:attributes).reduce(&:deep_merge)
      row.delete('id')
      row['id'] = row.delete('_id') if row['_id']
      row['id'] = row.delete('index') unless row['id']
      row.delete('index')
      row
    end
  end

  def where(options = nil, value = nil)
    options ||= {}
    if String === options
      options.tap do |key|
        options = {}
        options[key] = value
      end
    end
  end

  def columns_names
    columns.select('name').collect(&:name)
  end

  before_create do
    assign_default_slug if self.slug.nil?
  end

  after_save do
    if csv_file_name_changed? && csv_file_name_was.nil?
      require 'csv'
      csv = CSV.new(File.read(self.csv.path))
      headers = csv.headers || csv.shift
      headers.each_with_index do |header, index|
        columns.create(name: header, index: index)
      end
      csv.each_with_index do |row, row_index|
        row.each_with_index do |value, value_index|
          resource_column = columns.find_by_index(value_index)
          resource_column.rows.create(index: row_index, value: value)
        end
      end
    end
  end

  private

  def assign_default_slug
    slug = (
      if csv?
        File.basename(csv.path, '.csv')
      else
         name
      end
    ).underscore.gsub(' ', '')
    assign_attributes(slug: slug)
  end
end
