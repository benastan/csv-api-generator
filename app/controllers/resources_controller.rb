class ResourcesController < ApplicationController
  respond_to :html

  def new
    @resource = Resource.new
  end

  def create
    csv = params.require(:resource).permit(:name, :csv)
    @resource = Resource.create(csv)
    redirect_to @resource
  end
end
