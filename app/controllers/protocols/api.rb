class Protocols::Api < Trailblazer::Endpoint::Protocol
  step Subprocess(Auth::Operation::AuthenticateToken), replace: :authenticate, id: :authenticate, Output(:failure) => Track(:not_authenticated)
  step Subprocess(Auth::Operation::Policy), replace: :policy, id: :policy, Output(:failure) => Track(:not_authorized)
end
