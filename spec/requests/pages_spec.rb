require 'rails_helper'

RSpec.describe "Pages", type: :request do
  before do
    allow_any_instance_of(GithubService).to receive(:call).and_return([])
    allow_any_instance_of(CodewarsService).to receive(:call).and_return(nil)
  end

  describe "GET /" do
    it "returns 200" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /curriculum_vitae" do
    before do
      create_list(:skill, 2)
      create(:education)
      create(:experience)
    end

    it "returns 200" do
      get curriculum_vitae_path
      expect(response).to have_http_status(:ok)
    end

    it "displays the developer name" do
      get curriculum_vitae_path
      expect(response.body).to include("Christof Van Berendonck")
    end
  end

  describe "GET /portfolio" do
    it "returns 200" do
      get portfolio_path
      expect(response).to have_http_status(:ok)
    end
  end
end
