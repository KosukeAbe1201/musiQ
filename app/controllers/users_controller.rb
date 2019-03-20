class UsersController < ApplicationController
  include ApplicationHelper
  before_action :forbid_login_user, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "登録を完了しました"
      session[:user_id] = @user.id
      redirect_to_with_ajax(new_post_path)
    else
      @error_message = "名前が既に使用されている、またはパスワードに不備があります。パスワードは8文字以上で入力してください。"
      render("users/new")
    end
  end

  def destroy
    User.find(@current_user.id).destroy
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(
        :name,
        :password,
      )
    end
end
