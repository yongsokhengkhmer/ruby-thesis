class MessagesController < ApplicationController
  load_and_authorize_resource

  def create
    @message = current_user.message_senders.new message_params
    flash[:alert] = "flashes.messages.create.fail" unless @message.save
    respond_to do |format|
      format.js
    end
  end

  private
  def message_params
    params.require(:message).permit Message::MESSAGE_PARAMS
  end
end
