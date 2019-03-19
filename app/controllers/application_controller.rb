class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :set_current_user
  before_action :set_posts_counter

  MAX_POST_COUNTER = 5

  def set_posts_counter
    @post_counter = Post.return_posts_num(session[:user_id])
  end

  def forbid_make_quiz
    if @post_counter >= MAX_POST_COUNTER
      redirect_to_with_ajax(root_path)
    end
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user.nil?
      flash[:notice] = "ログインが必要です"
      redirect_to_with_ajax(new_session_path)
    end
  end

  def forbid_login_user
    redirect_to_with_ajax(root_path) if @current_user
  end
end
