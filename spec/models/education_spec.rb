require 'rails_helper'

RSpec.describe Education, type: :model do
  describe "factory" do
    it "builds a valid education" do
      expect(build(:education)).to be_valid
    end
  end

  describe "optional fields" do
    it "is valid without a description" do
      expect(build(:education, description: nil)).to be_valid
    end

    it "is valid without an end_date (ongoing)" do
      expect(build(:education, end_date: nil)).to be_valid
    end
  end
end
