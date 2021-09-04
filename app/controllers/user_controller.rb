class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(id: params[:id])
    @events = @user.events.where("event_date > ?", Date.today ).page(params[:page]).per(6)
    @user.user_info = UserInfo.new if @user.user_info.blank?
  end

  def edit
    @user = User.find_by(id: params[:id])
    return if @user.id == current_user.id

    flash[:alert] = '自分以外のプロフィールは編集できません'
    redirect_to user_path(current_user.id)
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.user_info.update(update_param)
      flash[:notice] = 'プロフィールの編集を完了しました'
      redirect_to user_path(current_user.id)
    else
      flash[:alert] = 'プロフィールの編集に失敗しました'
      render 'user/edit'
    end
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private

  def update_param
    params.require(:user_info).permit(:age, :sex, :bike, :favorite_maker, :touring_area)
  end
end
