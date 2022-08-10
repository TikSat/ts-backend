class Profile::Operation::Create < Base::Operation
  step Model(Profile, :new)
  step :assign_current_user
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()

  private

  def assign_current_user(_ctx, model:, current_user:, **)
    model.user_id = current_user.id
  end
end
