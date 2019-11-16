class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :is_event_admin, only: [:edit, :update, :destroy]

  def index
    @events = Event.where(validated: true)
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
      flash[:success] = "L'événement a été créé."
      redirect_to @event
    else
      flash.now[:error] = @event.errors.full_messages.to_sentence
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
      flash[:success] = "L'événement a été modifiié."
      redirect_to @event
    else
      flash.now[:error] = @event.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "L'événement a été supprimé."
      redirect_to action: 'index'
    end
  end

  private

  def is_event_admin
    @event = Event.find(params[:id])
    if current_user.is_admin == true
      return true
    else
      unless @event.admin_id == current_user.id || true_admin == true
        flash[:error] = "Tu ne peux pas voir cet élément"
        redirect_to action: 'index'
      end
    end
  end
end
