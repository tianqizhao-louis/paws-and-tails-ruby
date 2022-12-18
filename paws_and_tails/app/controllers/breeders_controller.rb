class BreedersController < ApplicationController
  before_action :set_breeder, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update]

  # GET /breeders
  def index
    @breeders = Breeder.all
    @is_admin = is_admin
  end

  # GET /breeders/1
  def show
    breeder_id = params[:id]
    @animals = Breeder.get_animals(breeder_id)
    @is_admin_or_current_breeder = is_admin_or_current_breeder
    @not_this_user = not_this_user

    @user_id = UserToBreeder.get_user_id(@breeder.id)
  end

  # GET /breeders/new
  def new
    if is_admin || (current_user.user_type.to_s == "breeder" && !UserToBreeder.exists?(user_id: current_user.id.to_s))
      @breeder = Breeder.new
    elsif !is_admin && UserToBreeder.exists?(user_id: current_user.id.to_s)
      flash[:notice] = "You have already linked with a breeder"
      redirect_to root_url
    else
      flash[:warning] = "You don't have the permission"
      redirect_to root_url
    end
  end

  # GET /breeders/1/edit
  def edit
  end

  # POST /breeders
  def create
    @breeder = Breeder.new(breeder_params)

    if @breeder.save
      if current_user.user_type.to_s != "admin"
        UserToBreeder.create!(:user_id => current_user.id.to_s, :breeder_id => @breeder.id)
      end
      redirect_to @breeder, notice: 'Breeder was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /breeders/1
  def update
    if @breeder.update(breeder_params)
      redirect_to @breeder, notice: 'Breeder was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /breeders/1
  # def destroy
  #   # redirect_to root_url
  #   # UserToBreeder.where(:breeder_id => @breeder.id).destroy
  #
  #   UserToBreeder.where(breeder_id: @breeder[:id]).first.destroy
  #
  #   @breeder.destroy
  #   redirect_to breeders_url, notice: 'Breeder was successfully destroyed.'
  # end

  def redesigned_destroy
    @breeder = Breeder.find(params[:id])
    UserToBreeder.where(breeder_id: params[:id]).first.destroy if UserToBreeder.exists?(breeder_id: params[:id])

    @breeder.destroy
    redirect_to breeders_url, notice: 'Breeder was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_breeder
    @breeder = Breeder.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def breeder_params
    params.require(:breeder).permit(:name, :city, :country, :price_level, :address, :email)
  end
end
