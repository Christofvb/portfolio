require "test_helper"

class ExperienceTest < ActiveSupport::TestCase
  test "has many projects" do
    experience = experiences(:job_one)
    assert_respond_to experience, :projects
    assert_equal 1, experience.projects.count
  end

  test "destroys associated projects when destroyed" do
    experience = experiences(:job_one)
    project_id = experience.projects.first.id
    experience.destroy
    assert_nil Project.find_by(id: project_id)
  end
end
