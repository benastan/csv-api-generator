class ResourceColumn < ActiveRecord::Base
  belongs_to :resource
  has_many :rows, class_name: :ResourceColumnValue

  def values
    value = rows.arel_table[:value].as(name == 'id' ? '_id' : name)
    index = rows.arel_table[:index]
    rows.select(:id).select(value).select(index)
  end
end
