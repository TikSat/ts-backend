class Auth::Form::SignUp < Base::Form
  property :email
  property :password
  property :password_confirmation

  validation name: :default do
    params do
      required(:email).value(:string)
      required(:password).value(:string)
      required(:password_confirmation).value(:string)
    end
  end
end
