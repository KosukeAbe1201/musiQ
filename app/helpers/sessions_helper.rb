module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    flash[:notice] = "ログインしました"
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def log_out
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end
end
