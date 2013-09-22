class ResourceRecordsController < ApplicationController
  before_action do
    slug = params.require(:slug)
    @resource = Resource.find_by_slug(slug) rescue nil
  end
  authorize_resource :resource
  respond_to :json

  def index
    respond_with @resource.records
  end

  def show
    id = params.require(:id)
    record = @resource.records.select { |record| record['id'] == id }.first
    respond_with record
  end
end
