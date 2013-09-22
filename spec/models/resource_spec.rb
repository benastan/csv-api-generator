require 'spec_helper'

describe Resource do
  it { should belong_to :service }
  it { should have_many :columns }
  let(:resource) { FactoryGirl.build(:resource) }
  let(:csv) { File.new(File.join(Rails.root, 'spec', 'support', 'csv', 'users.csv')) }
  subject { resource }
  describe 'default values' do
    context 'when no csv is supplied' do
      before { subject.save }
      its(:slug) { should == 'user' }
    end
    context 'when a csv is supplied' do
      before { subject.update_attributes(csv: csv) }
      its(:slug) { should == 'users' }
    end
  end
  describe 'create from csv' do
    subject { resource.update_attributes(csv: csv) }
    it 'creates ResourceColumns from the csv' do
      expect { subject }.to change(resource.columns, :count).by(3)
    end
    it 'creates ResourceColumnValues from the csv' do
      expect { subject }.to change(ResourceColumnValue, :count).by(9)
    end
  end
  describe 'getting records' do
    before { resource.update_attributes(csv: csv) }
    subject { resource.records }
    its(:count) { should == 3 }
  end
end
