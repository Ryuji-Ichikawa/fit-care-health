class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: :index
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def search
    @posts = Post.all
  end

  def set_search
    @search = Post.ransack(params[:q])
    @search_posts = @search.result(distinct: true)
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :profile, :image])
  end
end
