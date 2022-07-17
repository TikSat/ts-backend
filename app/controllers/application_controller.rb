class ApplicationController < ActionController::API
  include Pagy::Backend
  include Representation
  before_action :authenticate_resource

  alias current_user current_resource

  def authenticate_resource
    authenticate_and_set_user
  end

  def current_profile
    current_user.current_profile
  end
end
