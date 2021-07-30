class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "event_channel_#{message.event_id}", message: render_message(message)
  end

  private
  def render_message(message)
    ApplicationController.render_with_signed_in_user(message.user, partial: 'messages/message', locals: { message: message },as: "messages")
  end
end
