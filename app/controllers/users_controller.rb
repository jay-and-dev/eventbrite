class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :destroy]
  before_action :user_check, only: [:show, :destroy]

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "L\'utilisateur a été supprimé."
      redirect_to root_path
    end
  end

  private

  def user_check
    @user = User.find(params[:id])
    if current_user.is_admin == true
      return true
    else
      unless current_user.id == @user.id 
        flash[:warning] = "Connecte toi."
        redirect_to root_path
      end
    end    
  end
end
