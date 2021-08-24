class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "event_channel_#{message.event_id}",
                                 message: message, time: message.created_at.strftime('%m/%d %H:%M'), name: message.user.name
  end

  private

  def render_message(message)
    ApplicationController.render_with_signed_in_user(message.user, partial: 'messages/message',
                                                                   locals: { message: message }, as: 'messages')
  end
end
