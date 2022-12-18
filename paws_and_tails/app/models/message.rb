class Message < ApplicationRecord
  def self.show_conversation(from_user_id, to_user_id)
    messages = Message.where(from_user_id: from_user_id, to_user_id: to_user_id)
    messages.or(Message.where(from_user_id: to_user_id, to_user_id: from_user_id)).order(:created_at)
  end

  def self.show_inbox(from_user_id)
    from_me = Message.where(from_user_id: from_user_id)
    to_me = Message.where(to_user_id: from_user_id)

    distinct_id = Hash.new
    from_me.order(:created_at).each do | m |
      distinct_id[m.to_user_id] = m.created_at
    end

    to_me.order(:created_at).each do | m |
      distinct_id[m.from_user_id] = m.created_at
    end

    distinct_id
  end

  # def self.remove_messages_user(id)
  #   Message.where(from_user_id: id).destroy_all
  #   Message.where(to_user_id: id).destroy_all
  # end
end
