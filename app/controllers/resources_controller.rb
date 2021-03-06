class ResourcesController < ApplicationController
  before_action only: [ :new, :create ] do
    @resource = current_user.resources.new(resource_params) if current_user
  end
  authorize_resource
  respond_to :html

  def create
    @resource.save
    redirect_to @resource
  end

  def resource_params
    params.require(:resource).permit(:name, :csv) if params[:resource]
  end

  rescue_from CanCan::AccessDenied do
    redirect_to current_user ? :root : new_user_registration_path
  end
end
