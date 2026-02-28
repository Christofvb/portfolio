require "test_helper"

class SkillTest < ActiveSupport::TestCase
  test "valid with name and skill_type" do
    skill = Skill.new(name: "Ruby", skill_type: 0)
    assert skill.valid?
  end

  test "invalid without name" do
    skill = Skill.new(skill_type: 0)
    assert_not skill.valid?
    assert skill.errors[:name].any?
  end

  test "invalid with unknown skill_type" do
    skill = Skill.new(name: "Ruby", skill_type: 99)
    assert_not skill.valid?
  end

  test "skill_type_label returns humanized key" do
    skill = Skill.new(name: "Ruby", skill_type: 0)
    assert_equal "Language", skill.skill_type_label
  end

  test "all four skill types are valid" do
    Skill::SKILL_TYPES.each_value do |type|
      skill = Skill.new(name: "Test", skill_type: type)
      assert skill.valid?, "skill_type #{type} should be valid"
    end
  end
end
