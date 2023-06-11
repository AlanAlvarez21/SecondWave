# frozen_string_literal: true

# Fetch user country
class FetchCountryJob < ApplicationJob
  queue_as :default

  def perform(user_id, ip)
    country = FetchCountryService.new(ip).perform
    user = User.find(user_id)
    user.update(country: country) if country
  end
end
