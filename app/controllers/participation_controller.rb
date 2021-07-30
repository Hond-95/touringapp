class ParticipationController < ApplicationController
  before_action :set_event

  def create
    @user_event = UserEvent.new(user_id: current_user.id,  event_id: params[:id])
    @user_event.save
    @event = Event.find_by(id: params[:id])
  end

  def destroy
    @user_event = UserEvent.find_by(user_id: current_user.id,  event_id: params[:id])
    @user_event.destroy
  end

  private
  def set_event
    @event = Event.find_by(id: params[:id])
  end
end
