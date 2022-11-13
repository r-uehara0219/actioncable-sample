class RoomChannel < ApplicationCable::Channel
  def subscribed
    # broadcast
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create! content: data['message']
    ActionCable.server.broadcast 'room_channel', message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.render partial: 'messages/message', locals: { message: message }
  end
end
