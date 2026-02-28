require 'net/http'
require 'json'
require 'openssl'

class GithubService
  attr_reader :user_name
  BASE_URL = "https://api.github.com/users"

  def initialize(user_name = "Christofvb" )
    @user_name = user_name
  end

  def call
    Rails.cache.fetch("github_repos", expires_in: 1.day ) do
      fetch_repos
    end
  end

  private

  def fetch_repos
    uri = URI("#{BASE_URL}/#{user_name}/repos?sort=updated&per_page=100")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri)
    response = http.request(request)

    repos = JSON.parse(response.body)
    repos.reject { |r| r["fork"] }
  rescue StandardError => e
    Rails.logger.error("Erreur GitHub API: #{e.message}")
    []
  end
end
