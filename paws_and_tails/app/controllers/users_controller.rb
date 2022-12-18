class UsersController < ApplicationController

  before_action :authorize, only: [:show]

  def new
    @user = User.new
  end

  def show
    if is_current_user(params[:id]) || is_admin
      # UserToBreeder.create(:user_id => 1, :breeder_id => 1)
      @user = User.find(params[:id])
    else
      flash[:warning] = "You don't have the permission to view the profile."
      redirect_to root_url
    end
  end

  def create
    get_user_params = user_params
    get_user_params[:user_type] = params[:type_id]
    @user = User.new(get_user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  # def link_user_with_breeder
  #   if UserToBreeder.exists?(user_id: current_user.id.to_s)
  #     # if already exists
  #     flash[:notice] = "You have already linked with a breeder"
  #   else
  #     render new_breeder_path
  #   end
  # end

  private
  def user_params
    params.require(:user).permit(:user_name, :password, :password_confirmation, :user_type)
  end
end
