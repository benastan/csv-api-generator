require 'spec_helper'

describe ResourcesController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  describe '#new' do
    let(:_request) { get :new }
    subject { _request }
    it { should be_ok }
  end

  describe '#create' do
    let(:csv) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'csv', 'users.csv')) }
    let(:_request) { post :create, { resource: { name: 'User', csv: csv } } }
    subject { _request }
    before { subject }
    it { should redirect_to Resource.last }
  end
end
