class ChargesController < ApplicationController

def new
@event = Event.find(params[:event_id])
@amount = @event.price


end

def create
  # Amount
  #TO CREATE USE THE INFORMATIONS OF YOUR EVENT!

@event = Event.find(params[:event_id])
@token = params[:stripeToken]

  redirect_to new_event_attendance_path(params[:event_id])

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end

	
end
