class ApplicationController < ActionController::API
  include Pagy::Backend
  include Representation

  def current_user
    @current_user = User.last
  end
end
