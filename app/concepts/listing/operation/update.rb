class Listing::Operation::Update < Base::Operation
  step Model(Listing, :find_by, not_found_terminus: true)
  # step Policy::Guard(:update?)
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()

  private

  def update?(_options, current_profile:, model:, **)
    current_profile.listings.include?(model)
  end
end
