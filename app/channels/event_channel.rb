class EventChannel < ApplicationCable::Channel
  def subscribed
    stream_from "event_channel_#{params['event']}"
    stream_for current_user.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(message: data['message'],event_id: params['event'], user_id: current_user.id)
  end
end
