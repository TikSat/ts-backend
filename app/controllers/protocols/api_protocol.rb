class Protocols::ApiProtocol < Trailblazer::Endpoint::Protocol
  def authenticate(_ctx, **)
    true
  end

  def policy(_ctx, **)
    true
  end
end
