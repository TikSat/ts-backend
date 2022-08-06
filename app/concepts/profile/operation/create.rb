class Profile::Operation::Create
  step :build_model
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()

  private

  def build_model(ctx, current_user:, params:, **)
    ctx[:model] = current_user.profiles.build(params)
  end
end
