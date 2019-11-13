class AvatarsController < ApplicationController

  def new
  end
  # POST /avatars
  # POST /avatars.json
  def create
    @avatar = Avatar.new(avatar_params)
    @user = User.find(params[:user_id])
    @user.avatar.attach(params[:avatar])


      if @avatar.save
        flash[:success] =  "Avatar was successfully created." 
        redirect_to '/'
      else
      flash.now[:danger] = "Error attemprint to attend an event"
      render :action => 'new'
      end
  end

 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avatar
      @avatar = Avatar.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def avatar_params
      params.fetch(:avatar, {})
    end
end
