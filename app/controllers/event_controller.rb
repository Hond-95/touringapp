class EventController < ApplicationController
  before_action :authenticate_user!, {only: [:create,:new]}

  def home
    @events = current_user.events
  end

  def new
    @event = Event.new
    @event.users << current_user
  end

  def index

  end
  
  def search
    @events = Event.search(params[:keyword],params[:date])
    @keyword = params[:keyword]
    @date = params[:date]
    render '/event/index'
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def edit
    @event = Event.find_by(id: params[:id])
  end

  def chat
    @event = Event.find_by(id: params[:id])
    @messages = @event.messages
    @users = @event.users
  end

  def create
    @event = Event.new(event_param)
    @event.user_ids = current_user.id
    if @event.save
      flash[:notice] = "ツーリングの登録を完了しました"
      redirect_to home_path
    else
      flash[:notice] = "ツーリングの登録に失敗しました"
      render '/event/new'
    end
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(update_param)
      flash[:notice] = "ツーリングの編集を完了しました"
      redirect_to home_path
    else
      flash[:notice] = "ツーリングの編集に失敗しました"
      render 'event/edit'
    end
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    if @event.destroy
      flash[:notice] = "ツーリングの削除を完了しました"
      redirect_to home_path
    else
      flash[:notice] = "ツーリングの編集に失敗しました"
      render 'edit'
    end
  end

  private

  def event_param
    params.require(:event).permit(:title, :event_date, :comment, :recruting_count, :run_location, :meeting_place ,user_ids: []).merge(owner_id: current_user.id)
  end

  def update_param
    params.permit(:title, :event_date, :comment, :recruting_count, :run_location, :meeting_place )
  end
end
