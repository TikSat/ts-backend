class Api::Admin::BaseController < ApplicationController
  before_action :authenticate_resource
  # check admin rights here
end
