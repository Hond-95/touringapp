class Message < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :message, presence: true

  after_create_commit { MessageBroadcastJob.perform_later self }
end
