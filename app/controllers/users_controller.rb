class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :user_check, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  private

  def user_check
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      #flash[:warning] = "Connecte toi"
      redirect_to root_path
    end
  end
end
