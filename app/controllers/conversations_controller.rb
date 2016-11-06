class ConversationsController < ApplicationController
  load_and_authorize_resource
  before_action :load_conversations, only: [:index, :show]

  def index
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
  end

  private
  def conversation_params
    params.require(:conversation).permit Conversation::CONVERSATION_PARAMS
  end

  def load_conversations
    @conversations = Conversation.preload(:receiver).order created_at: :desc
  end
end
