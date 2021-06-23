class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def show
    @posts = @user.posts
  end

  def edit
    redirect_to root_path unless @user.id == current_user.id
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end
  
  def following
    #@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    #@userをフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
    params.require(:user).permit(:image, :nickname, :email, :profile)
  end
  def set_user
    @user = User.find(params[:id])
  end
end

