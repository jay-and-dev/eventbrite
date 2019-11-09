class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :is_event_admin, only: [:edit, :update, :destroy]

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
    @event.avatar.attach(params[:avatar])
    if @event.save
      #flash[:success] = "Le potin a été créé"
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    event_params = params.permit(:start_date, :duration, :title, :description, :price, :location)
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

  def is_event_admin
    @event = Event.find(params[:id])
    unless @event.admin_id == current_user.id
      redirect_to action: 'index'
    end
  end
  
end
