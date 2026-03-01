require "test_helper"

class ExperiencesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "unauthenticated user is redirected" do
    get experiences_path
    assert_redirected_to new_user_session_path
  end

  test "authenticated user can access index" do
    sign_in users(:admin)
    get experiences_path
    assert_response :success
  end

  test "authenticated user can create an experience" do
    sign_in users(:admin)
    assert_difference "Experience.count", 1 do
      post experiences_path, params: {
        experience: { job_title: "Dev", company: "ACME", start_date: "2024-01-01" }
      }
    end
  end
end
