# frozen_string_literal: true

require 'net/http'

# Fetch the user country using the api from the request
class FetchCountryService
  attr_reader :ip

  def initialize(ip)
    @ip = ip
  end

  def perform
    uri = URI("http://ip-api.com/json/#{ip}")
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)
    parsed_response['status'] == 'success' ? parsed_response['countryCode'].downcase : nil
  rescue StandardError
    nil
  end
end
