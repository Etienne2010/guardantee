class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @projects = Project.all
    @computed_data = Compute.new(@projects).computer
    if user_signed_in?
      @pledge = Pledge.where("user_id=? AND status=?", current_user.id, "pending").first
      if !@pledge.nil?
        puts "pledge"
        ap @pledge
        @pr = Project.where("id=?", @pledge.project).first
        puts "project"
        ap @pr
      end
    end
  end
end
