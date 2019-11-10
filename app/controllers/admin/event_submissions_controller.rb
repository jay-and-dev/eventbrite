class Admin::EventSubmissionsController < ApplicationController
  before_action :true_admin, only: [:index, :show, :edit, :update, :destroy]
  def index
    @events = Event.where(validated: nil)
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    event_params = params.permit(:validated)
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "L'événement a été supprimé"
      redirect_to action: 'index'
    end
  end

  private

  def true_admin
    unless current_user.is_admin == true 
      #flash[:warning] = "Connecte toi"
      redirect_to root_path
    end  
  end
end
