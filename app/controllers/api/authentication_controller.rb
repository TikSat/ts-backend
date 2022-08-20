class Api::AuthenticationController < ApplicationController
  _endpoint :create, Auth::Operation::SignIn

  def create
    endpoint :create, skip_auth: true
  end

  def success_render(ctx)
    render json: { token: ctx[:token],
                   refresh_token: ctx[:refresh_token],
                   token_expire_at: ctx[:token_expire_at] },
           status: ctx[:status]
  end
end
