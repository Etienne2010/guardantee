class ProjectsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  include Pundit
  after_action :verify_authorized, except: [:index, :show, :new, :create], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:index], unless: :skip_pundit?

  def index
    @projects = policy_scope(Project).where(user_id: current_user.id)
    @computed_data = Compute.new(@projects).computer
  end

  def show
    @project = Project.find(params[:id])
    @computed_data = Compute.new([@project]).computer
    @pledges = Pledge.where("project=?", @project.id).sort_by { |pl| pl.typeaction }
    @array_pledges = []
    @pledges.each do |pl|
      mhash = {}
      mhash[:pledge] = pl
      mhash[:email] = User.find(pl.user_id)[:email]
      @array_pledges << mhash
    end
  end

  def new
    @project = Project.new
    @user = current_user
  end

  def create
    @project = Project.new(proj_params)
    @project.user = current_user
    @project[:guaranteed] = 0
    @project[:status] = "pledging"
    if @project.save
      p "Project saved"
      redirect_to user_project_path(current_user, @project)
    else
      p @project.errors
      p "Project not saved"
    end
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def proj_params
    params.require(:project).permit(:title, :description, :price, :target, :images => [])
  end
end
