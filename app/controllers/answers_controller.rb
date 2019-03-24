class AnswersController < ApplicationController
  include ApplicationHelper

  def new
    @artist = Answer.search_artist(session[:answerer_id])
  end

  def create
    answer = Answer.new(answer_params)
    if answer.save
      session[:answerer] = answer.name
      redirect_to_with_ajax(answer_path(1))
    else
      @error_message = "既に使用されている名前です"
      render :new
    end
  end

  def show
    if params[:question_num]
      @post = Answer.search_post(params[:question_num].to_i, session[:answerer_id])
      @num = params[:question_num].to_i + 1
    end
  end

  def next_question
    now_question_num = params[:answer][:question_num].to_i - 1
    post = Answer.search_post(now_question_num, session[:answerer_id])
    answer = Answer.find_answer_by_name(session[:answerer])

    # 回答が正しいかどうか判定する
    is_correct_song = post.correct_song == params[:answer][:chosen_song]
    if is_correct_song
      Answer.update_correct_num(session[:answerer], answer)
      flash[:notice] = "正解です！"
    else
      flash[:notice] = "不正解です。正解は#{post.correct_song}でした"
    end

    #最後の設問であれば結果画面に、それ以外であれば次の問題画面に遷移する
    question = Question.find_by(user_id: session[:answerer_id])
    if now_question_num == question.num
      redirect_to_with_ajax(result_answers_path)
    else
      redirect_to_with_ajax(answer_path(params[:answer][:question_num]))
    end
  end

  def result
    @answer = Answer.find_answer_by_name(session[:answerer])
    @keyword = Answer.search_keyword(session[:answerer_id])
    @message = Answer.search_message(@answer.correct)
    @artist = Answer.search_artist(session[:answerer_id])
    session[:answerer_id] = nil
  end

  private

    def answer_params
      params.require(:answer).permit(
        :name,
        :user_id,
        :question_num,
      )
    end
end
