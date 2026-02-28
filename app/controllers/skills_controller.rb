class SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  def index
    @skills = Skill.all
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      redirect_to skills_path, notice: "Skill created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @skill.update(skill_params)
      redirect_to skills_path, notice: "Skill updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @skill.destroy
    redirect_to skills_path, notice: "Skill deleted successfully"
  end

  private

  def set_skill
    @skill = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit(:name, :image_path, :skill_type)
  end
end
