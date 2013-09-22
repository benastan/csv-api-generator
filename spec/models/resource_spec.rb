require 'spec_helper'

describe Resource do
  it { should belong_to :service }
  it { should have_many :resource_columns }
  let(:resource) { FactoryGirl.create(:resource) }
  let(:csv) { File.new(File.join(Rails.root, 'spec', 'support', 'csv', 'users.csv')) }
  describe 'create from csv' do
    subject { resource.update_attributes(csv: csv) }
    it 'creates ResourceColumns from the csv' do
      expect { subject }.to change(resource.resource_columns, :count).by(3)
    end
    it 'creates ResourceColumnValues from the csv' do
      expect { subject }.to change(ResourceColumnValue, :count).by(9)
    end
  end
end
