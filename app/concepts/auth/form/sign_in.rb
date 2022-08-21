class Auth::Form::SignIn < Base::Form
  property :email
  property :password

  validation name: :default do
    params do
      required(:email).value(:string)
      required(:password).value(:string)
    end
  end
end
