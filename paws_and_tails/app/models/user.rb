class User < ApplicationRecord

  has_secure_password

  validates_uniqueness_of :user_name

  def self.get_user_name(id)
    User.find_by_id(id)[:user_name]
  end

  # def self.destroy_dependencies(id)
  #   Waitlist.remove_user_from_waitlist(id)
  #   Message.remove_messages_user(id)
  # end
end
