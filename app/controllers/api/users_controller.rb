class Api::UsersController < ApplicationController
  _endpoint :show, User::Fetch

  def controller_representer
    User::Representer
  end
end
