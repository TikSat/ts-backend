class Profile::Operation::Update
  step :find_model
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()

  private

  def find_model(ctx, current_user:, params:, **)
    ctx[:model] = current_user.profiles.find(params[:id])
  end
end
