class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :search]
  def index
    @tag_list = Tag.all
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tag_name].split(nil)
    if @post.save
      @post.save_tag(tag_list)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post_tags = @post.tags
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @like = Like.new
  end

  def edit
    redirect_to root_path unless @post.user_id == current_user.id
  end

  def update
    tag_list = params[:post][:tag_name].split(nil)
    if @post.update(post_params)
      @post.save_tag(tag_list)
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def search
    if params[:tag_id].nil?
      @q = Post.ransack(params[:q])
      @posts = @q.result(distinct: true)
    else
      @tag_list = Tag.all
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.all
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
