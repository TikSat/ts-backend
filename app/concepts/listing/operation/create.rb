class Listing::Operation::Create
  step :build_model
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()

  private

  def build_model(ctx, current_profile:, params:, **)
    ctx[:model] = current_profile.listings.build(params)
  end
end
