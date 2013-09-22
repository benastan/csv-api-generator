require 'spec_helper'

describe ResourceColumn do
  it { should belong_to :resource }
  it { should have_many :resource_column_values }
end
