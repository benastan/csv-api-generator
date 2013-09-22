require 'spec_helper'

describe ResourceColumn do
  it { should belong_to :resource }
  it { should have_many :rows }
end
