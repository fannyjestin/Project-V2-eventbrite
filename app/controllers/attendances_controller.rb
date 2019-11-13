class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :index, :destroy, :create]
  before_action :is_owner, only: [:new, :index, :destroy, :create]

  def new
    create
  end
  #pour appeler la méthode create du même controller, obliger de passer parr new avant create

  def index
    @event = Event.find(params[:event_id])   
    @count = Event.find(params[:event_id]).users.all.count
    @guests = Event.find(params[:event_id]).users.all
  end

  def create
    @attendance = Attendance.new(user: current_user, stripe_customer_id: params[:token], event: Event.find(params[:event_id]))
  
   if @attendance.save
      flash[:success] = "You successfuly attended an event"
      redirect_to user_path(@current_user)
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      flash.now[:danger] = "Error attemprint to attend an event"
      render :action => 'new'
    end

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
