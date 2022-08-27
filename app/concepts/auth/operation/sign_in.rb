class Auth::Operation::SignIn < Base::Operation
  include ApiGuard::JwtAuth::JsonWebToken
  include ApiGuard::JwtAuth::RefreshJwtToken

  step Model(User, :find_by, :email, id: 'find_by_email')
  step Contract::Build(constant: Auth::Form::SignIn)
  step Contract::Validate()
  step :authenticate
  step :generate_token

  private

  def authenticate(_ctx, params:, model:, **)
    model.authenticate(params[:password])
  end

  def generate_token(ctx, model:, **)
    ctx[:token], ctx[:refresh_token] = jwt_and_refresh_token(model, 'user')
    ctx[:token_expire_at] = token_expire_at.to_s
  end
end
