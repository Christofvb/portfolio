require 'rails_helper'

RSpec.describe GithubService do
  subject(:service) { described_class.new }

  let(:api_url) { "https://api.github.com/users/Christofvb/repos?per_page=100&sort=updated" }
  let(:repos_payload) do
    [
      { "name" => "portfolio", "fork" => false, "html_url" => "https://github.com/Christofvb/portfolio", "language" => "Ruby", "description" => "My portfolio" },
      { "name" => "fork-repo", "fork" => true,  "html_url" => "https://github.com/Christofvb/fork-repo",  "language" => "Ruby", "description" => nil }
    ]
  end

  describe "#call" do
    context "when the API responds successfully" do
      before do
        stub_request(:get, api_url)
          .to_return(status: 200, body: repos_payload.to_json, headers: { "Content-Type" => "application/json" })
      end

      it "returns only non-forked repos" do
        result = service.call
        expect(result.map { |r| r["name"] }).to eq([ "portfolio" ])
      end

      it "goes through the cache" do
        expect(Rails.cache).to receive(:fetch).with("github_repos", expires_in: 1.day).and_call_original
        service.call
      end
    end

    context "when the API is unavailable" do
      before do
        stub_request(:get, api_url).to_raise(StandardError.new("timeout"))
      end

      it "returns [] without raising an exception" do
        expect(service.call).to eq([])
      end
    end
  end
end
