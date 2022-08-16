class Listing::Operation::Update < Base::Operation
  step Model(Listing, :find_by)
  step Policy::Guard(:update?)
  step Contract::Build(constant: Listing::Form)
  step Contract::Validate()
  step Contract::Persist()

  private

  def update?(_options, current_profile:, model:, **)
    current_profile.listings.include?(model)
  end
end
