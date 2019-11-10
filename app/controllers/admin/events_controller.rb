class Admin::EventsController < ApplicationController
  include ApplicationHelper
  before_action :true_admin, only: [:index]

  def index
    @events = Event.all
  end

  private

  def true_admin
    unless current_user.is_admin == true 
      #flash[:warning] = "Connecte toi"
      redirect_to root_path
    end  
  end
end
