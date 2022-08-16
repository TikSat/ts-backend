class Listing::Operation::Create < Base::Operation
  step Model(Listing, :new)
  step Contract::Build(constant: Listing::Form)
  step Contract::Validate()
  step Contract::Persist()
end
