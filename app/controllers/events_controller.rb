class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new 
    @event = Event.new
  end

  def create
    @event = Event.new(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin_id: current_user.id)
    if @event.save
      flash[:success] = "Le potin a été créé"
      redirect_to :show
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "Le potin a été supprimé"
      redirect_to action: 'index'
    end
  end
end
