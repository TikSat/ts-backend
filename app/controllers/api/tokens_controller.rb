class Api::TokensController < ApplicationController
  _endpoint :create, Auth::Operation::RefreshTokens

  def create
    endpoint :create, skip_auth: true
  end

  def success_render(ctx)
    nctx = ctx[:endpoint_ctx][:domain_ctx]
    token = nctx[:token]
    refresh_token = nctx[:refresh_token]
    token_expire_at = nctx[:token_expire_at]

    render json: { token:,
                   refresh_token:,
                   token_expire_at: },
           status: ctx[:status]
  end
end
