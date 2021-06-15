class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def show
    @posts = @user.posts
  end

  def edit
    redirect_to root_path unless @post.user_id == current_user.id
  end

  def update
    if @user.update(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:image, :nickname, :email, :profile)
  end
  def set_user
    @user = User.find(params[:id])
  end
end

