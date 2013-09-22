class ResourcesController < ApplicationController
  respond_to :json

  def index
    slug = params.require(:slug)
    @resource = Resource.find_by_slug(slug) rescue nil
    respond_with @resource.records
  end

  def show
    slug = params.require(:slug)
    id = params.require(:id)
    @resource = Resource.find_by_slug(slug) rescue nil
    record = @resource.records.select { |record| record['id'] == id }.first
    respond_with record
  end
end
