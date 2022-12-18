class MessagesController < ApplicationController
  before_action :authorize, only: [:show]
  skip_before_action :verify_authenticity_token

  def show
    @from_user_id = current_user.id.to_s
    @to_user_id = params[:to_user_id].to_s
    @conversations = Message.show_conversation(@from_user_id.to_i, @to_user_id.to_i)

    if @to_user_id.to_s == "-1"
      render "no_user"
    else
      @from_user_name = User.get_user_name(@from_user_id)
      @to_user_name = User.get_user_name(@to_user_id)
      render "show"
    end
  end

  def create
    Message.create!(messages_param)
    new_messages = Message.show_conversation(messages_param["from_user_id"].to_i, messages_param["to_user_id"].to_i)

    from_user_name = User.get_user_name(messages_param["from_user_id"])
    to_user_name = User.get_user_name(messages_param["to_user_id"])

    respond_to do | format |
      format.js { render partial: "conversation", locals: {conversations: new_messages, from_user_id: messages_param["from_user_id"], from_user_name: from_user_name, to_user_name: to_user_name} }
    end
  end

  def inbox
    @message_to_users = Message.show_inbox(current_user.id.to_s)
  end


  private
  def messages_param
    params.require(:message).permit(:from_user_id, :to_user_id, :content)
  end
end
