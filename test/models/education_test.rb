require "test_helper"

class EducationTest < ActiveSupport::TestCase
  test "can be created with valid attributes" do
    education = Education.new(
      school: "MIT",
      degree: "Master",
      start_date: Date.new(2020, 9, 1),
      end_date: Date.new(2022, 6, 30)
    )
    assert education.valid?
  end

  test "end_date can be nil (still studying)" do
    education = Education.new(school: "MIT", start_date: Date.new(2023, 9, 1))
    assert education.valid?
  end
end
