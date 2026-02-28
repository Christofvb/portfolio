require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:experience) }
  end

  describe "factory" do
    it "builds a valid project" do
      expect(build(:project)).to be_valid
    end

    it "is invalid without an experience" do
      expect(build(:project, experience: nil)).not_to be_valid
    end
  end
end
