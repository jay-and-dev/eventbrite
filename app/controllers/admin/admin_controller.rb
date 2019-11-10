class Admin::AdminController < ApplicationController
  before_action :true_admin, only: [:index]
  def index
  end
  
  private

  def true_admin
    unless current_user.is_admin == true 
      #flash[:warning] = "Connecte toi"
      redirect_to root_path
    end  
  end
end
