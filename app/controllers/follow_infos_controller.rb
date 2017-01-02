class FollowInfosController < ApplicationController
  load_resource :user

  def followings
    @followings = @user.followeds.preload(followed: :user_profile).page params[:page]
    respond_to do |format|
      format.html {render "profiles/index"}
      format.js
    end
  end

  def followers
    @followers = @user.followers.preload(follower: :user_profile).page params[:page]
    respond_to do |format|
      format.html {render "profiles/index"}
      format.js
    end
  end
end
