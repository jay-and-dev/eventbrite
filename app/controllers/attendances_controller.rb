class AttendancesController < ApplicationController
  before_action :is_attendances_admin, only: [:index]

  def index
    @event = Event.find(params[:event_id])
    @attendances = @event.attendances
  end

  def new
    @attendance = Attendance.new  
    @event = Event.find(params[:event_id])
    @amount = @event.price*100
  end

  def create
    @event = Event.find(params[:event_id])

    @amount = @event.price*100
    
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Paiement de l\événement',
      currency: 'eur',
    })
    

    @attendance = Attendance.new(stripe_customer_id: customer.id, user_id: current_user.id, event_id: @event.id)
    @attendance.save 
      
    redirect_to @event  
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      render :new 
  end

  def edit

  end

  def update

  end

  private

  def is_attendances_admin
    @event = Event.find(params[:event_id])
    unless @event.admin_id == current_user.id
      redirect_to events_path
    end
  end

end
