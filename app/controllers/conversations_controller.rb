class ConversationsController < ApplicationController
  load_and_authorize_resource

  def index
    load_conversations
  end

  def create
    @conversation = current_user.conversation_senders.new conversation_params
    @existing_conversation = Conversation.existing_conversation current_user.id, @conversation.receiver_id
    if @existing_conversation.blank?
      if @conversation.save
        url = @conversation
      else
        flash.now[:alert] = "conversations.create.fail"
        url = conversations_path
      end
    else
      url = conversation_path @existing_conversation.first.id
    end
    redirect_to url
  end

  def show
    @messages = @conversation.messages.load_messages.page params[:page]

    respond_to do |format|
      format.js
      format.html {load_conversations}
    end
  end

  private
  def conversation_params
    params.require(:conversation).permit Conversation::CONVERSATION_PARAMS
  end

  def load_conversations
    @conversations = Conversation.load_conversations_of current_user.id
  end
end
