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
    @event = Event.new(start_date: params[:start_date][0], duration: params[:duration][0], title: params[:title], description: params[:description], price: params[:price][0], location: params[:location], admin_id: current_user.id)
    if @event.save
      #flash[:success] = "Le potin a été créé"
      redirect_to @event
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "L'événement a été supprimé"
      redirect_to action: 'index'
    end
  end
end
