class Profile::Operation::Create < Base::Operation
  step Model(Profile, :new)
  step Contract::Build(constant: Base::Form)
  step Contract::Validate()
  step Contract::Persist()
end
