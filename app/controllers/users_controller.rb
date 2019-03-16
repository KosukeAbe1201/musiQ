class UsersController < ApplicationController
  before_action :forbid_login_user, except: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "登録を完了しました"
      session[:user_id] = @user.id
      respond_to do |format|
        format.html { redirect_to new_post_path }
        format.js
      end
    else
      @error_message = "名前が既に使用されている、またはパスワードに不備があります。パスワードは8文字以上で入力してください。"
      render("users/new")
    end
  end

  private

    def user_params
      params.require(:user).permit(
        :name,
        :password,
      )
    end
end
