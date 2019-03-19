class AnswersController < ApplicationController
  include ApplicationHelper
  MAX_QUIZZES_NUM = "5"

  def new
    @artist = Answer.search_artist(session[:answerer_id])
  end

  def create
    answer = Answer.new(answer_params)
    if answer.save
      session[:answerer] = answer.name
      redirect_to_with_ajax("/question1")
    else
      @error_message = "既に使用されている名前です"
      render("answers/new")
    end
  end

  def q1
    @post = Answer.search_post(1, session[:answerer_id])
  end

  def q2
    @post = Answer.search_post(2, session[:answerer_id])
  end

  def q3
    @post = Answer.search_post(3, session[:answerer_id])
  end

  def q4
    @post = Answer.search_post(4, session[:answerer_id])
  end

  def q5
    @post = Answer.search_post(5, session[:answerer_id])
  end

  def update
    post = Answer.search_post(params[:answer][:question_num], session[:answerer_id])
    answer = Answer.find_answer_by_name(session[:answerer])
    
    is_correct_song = post.correct_song == params[:answer][:chosen_song]
    if is_correct_song
      Answer.update_correct_num(session[:answerer], answer)
      flash[:notice] = "正解です！"
    else
      flash[:notice] = "不正解です。正解は#{post.correct_song}でした"
    end

    if params[:answer][:question_num] == MAX_QUIZZES_NUM
      redirect_to_with_ajax("/result")
    else
      redirect_to_with_ajax("/question#{params[:answer][:question_num].to_i + 1}")
    end
  end

  def result
    @answer = Answer.find_answer_by_name(session[:answerer])
    @keyword = Answer.search_keyword(session[:answerer_id])
    @message = Answer.search_message(@answer.correct)
    @artist = Answer.search_artist(session[:answerer_id])
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
