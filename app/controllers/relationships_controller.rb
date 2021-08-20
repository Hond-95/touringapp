class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    #@user = User.find(params[:following_id])
    @user = User.find(params[:relationship][:following_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.js
    end
  end

  def destroy
    #@user = User.find(params[:id])
    @user = User.find(params[:relationship][:following_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.js
    end
  end
end
