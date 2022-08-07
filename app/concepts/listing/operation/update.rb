class Listing::Operation::Update
  step :find_model
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()

  private

  def find_model(ctx, current_profile:, params:, **)
    ctx[:model] = current_profile.listings.find(params[:id])
  end
end
