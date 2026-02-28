require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_inclusion_of(:skill_type).in_array(Skill::SKILL_TYPES.values) }
  end

  describe "SKILL_TYPES" do
    it "defines the 4 expected types" do
      expect(Skill::SKILL_TYPES.keys).to match_array(%i[language framework tool other])
    end

    it "maps the correct integer values" do
      expect(Skill::SKILL_TYPES[:language]).to  eq(0)
      expect(Skill::SKILL_TYPES[:framework]).to eq(1)
      expect(Skill::SKILL_TYPES[:tool]).to      eq(2)
      expect(Skill::SKILL_TYPES[:other]).to     eq(3)
    end
  end

  describe "#skill_type_label" do
    it "returns the humanized label" do
      skill = build(:skill, skill_type: 0)
      expect(skill.skill_type_label).to eq("Language")
    end

    it "returns the correct label for each type" do
      Skill::SKILL_TYPES.each do |key, value|
        skill = build(:skill, skill_type: value)
        expect(skill.skill_type_label).to eq(key.to_s.humanize)
      end
    end
  end

  describe "factory" do
    it "builds a valid skill" do
      expect(build(:skill)).to be_valid
    end

    it "builds a valid :language skill" do
      expect(build(:skill, :language)).to be_valid
    end

    it "is invalid without a name" do
      expect(build(:skill, name: nil)).not_to be_valid
    end

    it "is invalid with an unknown skill_type" do
      expect(build(:skill, skill_type: 99)).not_to be_valid
    end
  end
end
