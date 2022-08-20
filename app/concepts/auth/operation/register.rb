class Auth::Operation::Register < Base::Operation
  include ApiGuard::JwtAuth::JsonWebToken
  include ApiGuard::JwtAuth::RefreshJwtToken

  step Model(User, :new)
  step Contract::Build(constant: Auth::Form::Registration)
  step Contract::Validate()
  step Contract::Persist()
  step :generate_token

  private

  def generate_token(ctx, model:, **)
    ctx[:token], ctx[:refresh_token] = jwt_and_refresh_token(model, 'user', true)
    ctx[:token_expire_at] = token_expire_at.to_s
  end
end
