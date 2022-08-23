class Auth::Operation::AuthenticateToken < Base::Operation
  attr_reader :token, :current_user

  step :auth

  private

  def auth(ctx, request:, **)
    return true if ctx[:skip_auth]

    @token = request.headers['Authorization']&.split('Bearer ')&.last

    authenticate_token

    return false unless current_user

    ctx[:domain_ctx][:current_user] = current_user
    ctx[:domain_ctx][:current_profile] = current_user&.current_profile

    true
  rescue JWT::DecodeError => _e
    false
  end

  def authenticate_token
    find_resource_from_token
  end

  def decoded_token
    @decoded_token = decode(token, false)
  end

  def find_resource_from_token
    user_id = decoded_token[:user_id]
    return if user_id.blank?

    @current_user = User.find_by(id: user_id)
  end

  def decode(token, verify = true)
    HashWithIndifferentAccess.new(
      JWT.decode(token, ApiGuard.token_signing_secret, verify, verify_iat: true)[0]
    )
  end
end
