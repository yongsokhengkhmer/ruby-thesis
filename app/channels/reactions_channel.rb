class ReactionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "reaction_channel"
  end

  def unsubscribed
  end
end
