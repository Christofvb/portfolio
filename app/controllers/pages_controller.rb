class PagesController < ApplicationController
  before_action :set_skills, :set_educations, :set_experiences, only: [ :resume ]
  before_action :set_codewars_profile, only: [ :resume ]
  before_action :set_repos, only: [ :portfolio ]

  def home; end

  def resume; end

  def portfolio; end

  private

  def set_skills
    @skills = Skill.all
  end

  def set_educations
    @educations = Education.all
  end

  def set_experiences
    @experiences = Experience.all
  end

  def set_codewars_profile
    @codewars_profile = CodewarsService.new.call
  end

  def set_repos
    @repos = GithubService.new.call
  end
end
