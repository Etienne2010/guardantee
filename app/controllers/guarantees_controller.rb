class GuaranteesController < ApplicationController
  before_action :authenticate_user!

  def create
    puts "create"
    pledge_id = guarantees_params[:pledge_id]
    pledge = Pledge.find(pledge_id)
    project = Project.find(pledge.project)
    if project.user_id == current_user.id
      pledge.status = "refunded_by_investor"
      pledge.save
    end
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def guarantees_params
    params.permit(:pledge_id)
  end
end
