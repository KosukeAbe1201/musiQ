class KeywordsController < ApplicationController
  include ApplicationHelper
  def create
    keyword = @current_user.build_keyword(keyword_param)
    if keyword.save
      redirect_to_with_ajax(share_keywords_path)
    else
      @error_message = "合言葉が入力されていない、または既に使用されています"
      render :new
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
      redirect_to_with_ajax(new_answer_path)
    else
      @error_message = "合言葉が存在しません"
      render :top
    end
  end

  private

  def keyword_param
    params.require(:keyword).permit(
      :keyword,
    )
  end
end
