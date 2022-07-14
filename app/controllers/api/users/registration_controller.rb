class API::Users::RegistrationController < ApplicationController
  skip_before_action :authenticate_resource

  def create
    init_resource(sign_up_params)
    if resource.save
      create_token_and_set_header(resource, resource_name)
      render_success(message: 'Signed up')
    else
      render_error(422, object: resource)
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end
end
