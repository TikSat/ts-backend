class ApplicationController < ActionController::API
  include Pagy::Backend
  include Representation
end
