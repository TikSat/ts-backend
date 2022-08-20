module ApiHelpers
  def json_response
    @json_response ||= JSON.parse(response.body, symbolize_names: true)
  rescue JSON::ParserError
    nil
  end
end
