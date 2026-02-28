require "test_helper"

class SkillsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "unauthenticated user is redirected from index" do
    get skills_path
    assert_redirected_to new_user_session_path
  end

  test "unauthenticated user is redirected from new" do
    get new_skill_path
    assert_redirected_to new_user_session_path
  end

  test "authenticated user can access index" do
    sign_in users(:admin)
    get skills_path
    assert_response :success
  end

  test "authenticated user can create a skill" do
    sign_in users(:admin)
    assert_difference "Skill.count", 1 do
      post skills_path, params: { skill: { name: "PostgreSQL", skill_type: 2 } }
    end
    assert_redirected_to skills_path
  end

  test "authenticated user cannot create skill without name" do
    sign_in users(:admin)
    assert_no_difference "Skill.count" do
      post skills_path, params: { skill: { name: "", skill_type: 0 } }
    end
    assert_response :unprocessable_entity
  end

  test "authenticated user can destroy a skill" do
    sign_in users(:admin)
    skill = skills(:ruby)
    assert_difference "Skill.count", -1 do
      delete skill_path(skill)
    end
    assert_redirected_to skills_path
  end
end
