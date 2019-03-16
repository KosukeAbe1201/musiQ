class KeywordsController < ApplicationController

  def create
    keyword = Keyword.new(keyword_param)
    if keyword.save
      respond_to do |format|
        format.html { redirect_to("/share") }
        format.js
      end
    else
      @error_message = "合言葉が入力されていない、または既に使用されています"
      render("keywords/new")
    end
  end

  def share
    @keyword = Keyword.find_keyword_by_user_id(session[:user_id])
    @artist = Answer.search_artist(session[:user_id])
  end

  def check_keyword
    keyword = Keyword.find_by(keyword: params[:keyword])
    if keyword
      session[:answerer_id] = keyword.user_id
      respond_to do |format|
        format.html { redirect_to("/answers/new") }
        format.js
      end
    else
      @error_message = "合言葉が存在しません"
      render("top")
    end
  end

  private

  def keyword_param
    params.require(:keyword).permit(
      :keyword,
      :user_id
    )
  end
end
