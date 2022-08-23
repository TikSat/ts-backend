class Auth::Form::SignUp < Base::Form
  property :email
  property :password
  property :password_confirmation

  validation name: :default do
    params do
      required(:email).value(:string, :filled?)
      required(:password).value(:string, :filled?, min_size?: 6)
      required(:password_confirmation).value(:string, :filled?, min_size?: 6)
    end

    rule(:password_confirmation) do
      key.failure('must match with password') if values[:password] != values[:password_confirmation]
    end
  end
end
