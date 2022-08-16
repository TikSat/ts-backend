class Protocols::Api < Trailblazer::Endpoint::Protocol
  step Auth::Operation::Authenticate, inherit: true, replace: :authenticate, id: :authenticate
  step Auth::Operation::Policy, inherit: true, id: :policy, replace: :policy
end
