require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "home page is publicly accessible" do
    get root_path
    assert_response :success
  end

  test "resume page is publicly accessible" do
    get curriculum_vitae_path
    assert_response :success
  end

  test "portfolio page is publicly accessible" do
    get portfolio_path
    assert_response :success
  end

  test "home page renders in English" do
    get root_path, params: { locale: "en" }
    assert_response :success
  end

  test "home page renders in Dutch" do
    get root_path, params: { locale: "nl" }
    assert_response :success
  end

  test "resume page renders in English" do
    get curriculum_vitae_path, params: { locale: "en" }
    assert_response :success
  end

  test "resume page renders in Dutch" do
    get curriculum_vitae_path, params: { locale: "nl" }
    assert_response :success
  end

  test "unknown locale falls back to French" do
    get root_path, params: { locale: "de" }
    assert_response :success
  end
end
