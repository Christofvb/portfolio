require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "belongs to an experience" do
    project = projects(:project_one)
    assert_respond_to project, :experience
    assert_instance_of Experience, project.experience
  end

  test "invalid without experience" do
    project = Project.new(name: "Orphan")
    assert_not project.valid?
    assert project.errors[:experience].any?
  end
end
