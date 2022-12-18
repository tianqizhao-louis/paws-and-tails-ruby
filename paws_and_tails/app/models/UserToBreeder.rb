class UserToBreeder < ApplicationRecord

  def self.get_breeder_id(user_id)
    return UserToBreeder.find_by(user_id: user_id)[:breeder_id]
  end

  def self.get_user_id(breeder_id)
    if UserToBreeder.exists?(breeder_id: breeder_id)
      return UserToBreeder.find_by(breeder_id: breeder_id)[:user_id]
    else
      return -1
    end
  end

end
