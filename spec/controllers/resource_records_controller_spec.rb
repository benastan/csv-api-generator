require 'spec_helper'

describe ResourceRecordsController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  let(:resource) { FactoryGirl.build(:resource, user_id: user.id) }
  let(:csv) { File.new(File.join(Rails.root, 'spec', 'support', 'csv', 'users.csv')) }
  before { resource.update_attributes(csv: csv) }
  let(:first_record) { {"name"=>"Ben", "birthday"=>"3/30/1988", "id"=>"1"} }
  describe '#index' do
    let(:_request) { get :index, slug: resource.slug, format: :json }
    subject { _request }
    it { should be_ok }
    describe 'response' do
      subject { JSON.parse(_request.body) }
      its(:count) { should == 3 }
      its(:first) { should == first_record }
    end
  end
  describe '#show' do
    let(:_request) { get :show, id: '1', slug: resource.slug, format: :json }
    subject { _request }
    it { should be_ok }
    describe 'response' do
      subject { JSON.parse(_request.body) }
      let(:first_record) { {"name"=>"Ben", "birthday"=>"3/30/1988", "id"=>"1"} }
      it { should == first_record }
    end
  end
end
