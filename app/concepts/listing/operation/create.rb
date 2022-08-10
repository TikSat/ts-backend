class Listing::Operation::Create < Base::Operation
  step Model(Listing, :new)
  step :assign_profile
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()

  private

  def assign_profile(_ctx, current_profile:, model:, **)
    model.profile_id = current_profile.id
  end
end
