class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:user_id])
  end

  def new
    @project = Project.new
    @user = current_user
  end

  def create
    @project = Project.new(proj_params)
    @project.user = current_user
    if @project.save
      p "Project saved"
      redirect_to user_project_path(current_user, @project)
    else
      p @project.errors
      p "Project not saved"
    end
  end

  private

  def proj_params
    params.require(:project).permit(:images => [])
  end
end
