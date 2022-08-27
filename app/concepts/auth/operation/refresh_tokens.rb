class Auth::Operation::RefreshTokens < Base::Operation
  include ApiGuard::JwtAuth::JsonWebToken
  include ApiGuard::JwtAuth::RefreshJwtToken

  step :find_user
  step :find_refresh_token
  step :generate_token

  def find_user(ctx, params:, **)
    ctx[:current_user] = find_resource_from_token(params[:token])
  end

  def find_refresh_token(_ctx, params:, current_user:, **)
    find_refresh_token_of(current_user, params[:refresh_token])
  end

  def generate_token(ctx, current_user:, **)
    ctx[:token], ctx[:refresh_token] = jwt_and_refresh_token(current_user, 'user')
    ctx[:token_expire_at] = token_expire_at.to_s
    ctx
  end

  def decoded_token(token)
    @decoded_token = decode(token, false)
  end

  def find_resource_from_token(token)
    user_id = decoded_token(token)[:user_id]
    return if user_id.blank?

    User.find_by(id: user_id)
  end
end
