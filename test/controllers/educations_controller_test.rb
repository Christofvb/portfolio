require "test_helper"

class EducationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "unauthenticated user is redirected" do
    get educations_path
    assert_redirected_to new_user_session_path
  end

  test "authenticated user can access index" do
    sign_in users(:admin)
    get educations_path
    assert_response :success
  end

  test "authenticated user can create an education" do
    sign_in users(:admin)
    assert_difference "Education.count", 1 do
      post educations_path, params: {
        education: { school: "MIT", degree: "Master", start_date: "2020-09-01" }
      }
    end
  end

  test "field_of_study is not a permitted param" do
    sign_in users(:admin)
    post educations_path, params: {
      education: { school: "MIT", degree: "Master", start_date: "2020-09-01", field_of_study: "Hacking" }
    }
    education = Education.last
    assert_not_respond_to education, :field_of_study
  end
end
