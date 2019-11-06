class AttendancesController < ApplicationController
before_action :authenticate_user!, only: [:new, :index, :destroy, :create]
   before_action :is_owner, only: [:new, :index, :destroy, :create]

  def new
  end

  def index
    @event = Event.find(params[:event_id])   
    @count = Event.find(params[:event_id]).users.all.count
    @guests = Event.find(params[:event_id]).users.all
  end

  def create
  end

  def destroy
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    
    #NOMBRE DE USER INSCRIT À L'EVENT
      def count
        Event.find(params[:event_id]).users.all.count
      end


    def is_owner
      @event =  Event.find(params[:event_id])
      current_user.id == @event.admin_id
    end

end
