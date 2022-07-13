class API::UsersController < ApplicationController
  before_action :authenticate_resource

  def show
    present current_user
  end
end
