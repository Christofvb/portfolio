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

  test "stores job_title per locale via Mobility" do
    experience = Experience.create!(company: "TestCo", start_date: Date.today)
    Mobility.with_locale(:fr) { experience.update!(job_title: "Développeur") }
    Mobility.with_locale(:en) { experience.update!(job_title: "Developer") }

    assert_equal "Développeur", Mobility.with_locale(:fr) { experience.job_title }
    assert_equal "Developer",   Mobility.with_locale(:en) { experience.job_title }
  end

  test "falls back to French when EN/NL translation is missing" do
    experience = Experience.create!(company: "TestCo", start_date: Date.today)
    Mobility.with_locale(:fr) { experience.update!(job_title: "Développeur") }

    assert_equal "Développeur", Mobility.with_locale(:en) { experience.job_title }
    assert_equal "Développeur", Mobility.with_locale(:nl) { experience.job_title }
  end

  test "locale_accessor job_title_fr is equivalent to Mobility.with_locale(:fr)" do
    experience = Experience.new(company: "TestCo", start_date: Date.today)
    experience.job_title_fr = "Développeur"
    experience.save!

    assert_equal "Développeur", Mobility.with_locale(:fr) { experience.job_title }
  end
end
