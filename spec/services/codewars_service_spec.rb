require 'rails_helper'

RSpec.describe CodewarsService do
  subject(:service) { described_class.new }

  let(:api_url) { "https://www.codewars.com/api/v1/users/Christofvb" }
  let(:profile_payload) do
    {
      "honor" => 1500,
      "codeChallenges" => { "totalCompleted" => 289 },
      "ranks" => {
        "overall" => { "score" => 3200 },
        "languages" => {
          "ruby" => { "name" => "4 kyu", "color" => "blue" }
        }
      }
    }
  end

  describe "#call" do
    context "when the API responds successfully" do
      before do
        stub_request(:get, api_url)
          .to_return(status: 200, body: profile_payload.to_json, headers: { "Content-Type" => "application/json" })
      end

      it "returns the parsed profile" do
        result = service.call
        expect(result["honor"]).to eq(1500)
        expect(result.dig("codeChallenges", "totalCompleted")).to eq(289)
      end

      it "goes through the cache" do
        expect(Rails.cache).to receive(:fetch).with("codewars_profile", expires_in: 1.day).and_call_original
        service.call
      end
    end

    context "when the API is unavailable" do
      before do
        stub_request(:get, api_url).to_raise(StandardError.new("timeout"))
      end

      it "returns nil without raising an exception" do
        expect(service.call).to be_nil
      end
    end
  end
end
