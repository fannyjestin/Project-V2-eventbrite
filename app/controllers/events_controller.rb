class EventsController < ApplicationController
  
  before_action :authenticate_user!, only: [:new, :create, :show]
  before_action :is_owner, only: [:edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @user = current_user
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.admin_id = current_user.id
    respond_to do |format|
      if @event.save
        if params[:avatar]
        @event.avatar.attach(params[:avatar])
      else
        downloaded_image = open(Faker::LoremPixel.image(secure: false))
        @event.avatar.attach(io: downloaded_image  , filename: "faker.jpg")
      end
        flash[:success]= "Ton évenement a bien été créé !"
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update(event_params)
        @event.avatar.attach(params[:avatar])

        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = Event.find(params[:id]).admin_id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:start_date, :duration, :title, :price, :description, :location)
    end
    
    #NOMBRE DE USER INSCRIT À L'EVENT
      def count
        Event.find(params[:id]).users.all.count
      end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
    
   def authenticate_user
      unless current_user 
        flash[:danger] = "This section requires to be logged-in. Please log in."
        redirect_to new_user_session_url
      end
    end

    def is_owner
      if current_user.id.to_i != Event.find(params[:id]).admin_id
        flash[:danger] = "You can't acces this page"
        redirect_to "/"
      end
    end
end
