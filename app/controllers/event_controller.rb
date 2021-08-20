class EventController < ApplicationController
  before_action :authenticate_user!

  def home
    @events = current_user.events.order(event_date: "ASC")
    @owner_events = Event.find_by(owner_id: current_user.id)
  end

  def new
    @event = Event.new
    @event.users << current_user
  end

  def index
  end
  
  def search
    @events = Event.search(params[:keyword],params[:date]).page(params[:page]).per(6)
    @keyword = params[:keyword]
    @date = params[:date]
    render '/event/index'
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def edit
    @event = Event.find_by(id: params[:id])
    unless @event.owner_id == current_user.id
      flash[:alert] = "作成者以外は編集できません"
      redirect_to home_path
    end
  end

  def chat
    @event = Event.find_by(id: params[:id])
    if current_user.participate?(@event)
      @messages = @event.messages
      @users = @event.users
    else
      flash[:alert] = "参加者以外はトークルームに入れません"
      redirect_to home_path
    end
  end

  def create
    @event = Event.new(event_param)
    @event.user_ids = current_user.id
    if @event.save
      flash[:notice] = "ツーリングの登録を完了しました"
      redirect_to home_path
    else
      flash[:alert] = "ツーリングの登録に失敗しました"
      render '/event/new'
    end
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(update_param)
      flash[:notice] = "ツーリングの編集を完了しました"
      redirect_to home_path
    else
      flash[:alert] = "ツーリングの編集に失敗しました"
      render 'event/edit'
    end
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    if @event.destroy
      flash[:notice] = "ツーリングの削除を完了しました"
      redirect_to home_path
    else
      flash[:alert] = "ツーリングの編集に失敗しました"
      render 'edit'
    end
  end

  private

  def event_param
    params.require(:event).permit(:title, :event_date, :comment, :recruting_count, :run_location, :meeting_place ,user_ids: []).merge(owner_id: current_user.id)
  end

  def update_param
    params.require(:event).permit(:title, :event_date, :comment, :recruting_count, :run_location, :meeting_place )
  end
end
