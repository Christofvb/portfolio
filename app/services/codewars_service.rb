require "net/http"
require "json"
require "openssl"

class CodewarsService
  attr_reader :user_name
  BASE_URL = "https://www.codewars.com/api/v1"

  def initialize(user_name = "Christofvb")
    @user_name = user_name
  end

  def call
    Rails.cache.fetch("codewars_profile", expires_in: 1.day ) do
      fetch_profile
    end
  end

  private

  def fetch_profile
    uri = URI("#{BASE_URL}/users/#{user_name}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri)
    response = http.request(request)

    JSON.parse(response.body)
  rescue => e
    Rails.logger.error("Codewars API error: #{e.message}")
    nil
  end
end
