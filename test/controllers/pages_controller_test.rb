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
end
