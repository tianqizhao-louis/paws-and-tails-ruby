class WaitlistsController < ApplicationController
  before_action :authorize, only: [:join, :leave, :manage_remove]
  skip_before_action :verify_authenticity_token

  def join
    animal_id = waitlists_param["animal_id"]
    user_id = waitlists_param["user_id"]

    unless Waitlist.exists?(animal_id: animal_id, user_id: user_id)
      Waitlist.create!(waitlists_param)
    end

    this_waitlist = Waitlist.where(animal_id: animal_id, user_id: user_id).first
    total_place = Waitlist.where(animal_id: animal_id).count
    current_place = Waitlist.where(animal_id: animal_id).where("created_at < ?", this_waitlist.created_at).count + 1

    respond_to do | format |
      format.json { render json: {current_place: current_place, total_place: total_place} }
    end
  end

  def manage_remove
    animal_id = params["animal_id"]
    user_id = params["user_id"]

    Waitlist.where(animal_id: animal_id, user_id: user_id).first.destroy

    redirect_to Animal.find_by(id: animal_id), notice: 'User removed from waitlist'
  end

  def leave
    animal_id = waitlists_param["animal_id"]
    user_id = waitlists_param["user_id"]

    Waitlist.where(animal_id: animal_id, user_id: user_id).first.destroy

    respond_to do | format |
      format.json { render json: {status: "left"} }
    end
  end


  private
  def waitlists_param
    params.require(:waitlist).permit(:animal_id, :user_id)
  end
end
