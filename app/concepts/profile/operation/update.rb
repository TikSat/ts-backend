class Profile::Operation::Update < Base::Operation
  step Model(Profile, :find_by, not_found_terminus: true)
  # step Policy::Guard(:current_user?)
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()

  private

  def current_user?(_options, current_user:, model:, **)
    current_user.profiles.include?(model)
  end
end
