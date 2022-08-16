class Auth::Operation::Policy < Base::Operation
  step :check

  def check(_ctx, **)
    true
  end
end
