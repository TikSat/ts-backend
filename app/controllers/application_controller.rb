class ApplicationController < ActionController::API
  include Pagy::Backend
  include Representation

  alias :current_user :current_resource

  def authenticate_resource
    authenticate_and_set_user
  end
end
