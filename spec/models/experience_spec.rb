require 'rails_helper'

RSpec.describe Experience, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:projects).dependent(:destroy) }
  end

  describe "nested attributes" do
    it "accepts nested attributes for projects" do
      experience = create(:experience)
      experience.update!(
        projects_attributes: [ { name: "Test project", description: "Description" } ]
      )
      expect(experience.projects.count).to eq(1)
    end

    it "destroys projects via allow_destroy" do
      experience = create(:experience)
      project = create(:project, experience: experience)

      experience.update!(
        projects_attributes: [ { id: project.id, _destroy: "1" } ]
      )
      expect(experience.projects.count).to eq(0)
    end
  end

  describe "dependent destroy" do
    it "destroys associated projects when the experience is deleted" do
      experience = create(:experience)
      create_list(:project, 2, experience: experience)

      expect { experience.destroy }.to change(Project, :count).by(-2)
    end
  end
end
