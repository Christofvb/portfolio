class EducationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_education, only: [:show, :edit, :update, :destroy]

  def index
    @educations = Education.all
  end

  def new
    @education = Education.new
  end

  def create
    @education = Education.new(education_params)
    if @education.save
      redirect_to educations_path, notice: "Education created successfully"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @education.update(education_params)
      redirect_to educations_path, notice: "Education updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @education.destroy
    redirect_to educations_path, notice: "Education deleted successfully"
  end

  private

  def set_education
    @education = Education.find(params[:id])
  end

  def education_params
    params.require(:education).permit(:school, :degree, :start_date, :end_date, :description)
  end
end
