class ChargesController < ApplicationController

def new
@event = Event.find(params[:event_id])
@amount = @event.price

end

def create
  # Amount in cents

  customer = Stripe::Customer.create({
    email: params[:stripeEmail],
    source: params[:stripeToken],
  })

  charge = Stripe::Charge.create({
    customer: customer.id,
    amount: @amount,
    description: 'Rails Stripe customer',
    currency: 'usd',
  })

  redirect_to new_attendance_path(event: @event,token: @token)


rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end

	
end
