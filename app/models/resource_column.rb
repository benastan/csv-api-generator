class ResourceColumn < ActiveRecord::Base
  belongs_to :resource
  has_many :resource_column_values
end
