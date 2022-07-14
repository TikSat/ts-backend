class API::UsersController < ApplicationController
  def show
    present current_user
  end
end
