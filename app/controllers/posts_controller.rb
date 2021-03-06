class PostsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user
  before_action :forbid_make_quiz, except: [:destroy]

  MINIMUM_SONGS_NUM = 20

  def new
    @question = Question.new
  end

  def create
    all_songs = Post.fetch_songs_from_itunes_api(params[:post][:artist])

    if all_songs.size <= MINIMUM_SONGS_NUM
      flash[:notice] = "クイズが作れませんでした。"
      render("home/top")
      return
    end

    @question = @current_user.create_question(num: params[:post][:question][:num])

    @question.num.times do |i|
      correct_song = all_songs.sample
      chosen_songs = Post.choose_four_songs(correct_song, all_songs)
      post = @current_user.posts.create(
        question: correct_song["previewUrl"],
        question_num: i+1,
        answer1: chosen_songs[0]["trackName"],
        answer2: chosen_songs[1]["trackName"],
        answer3: chosen_songs[2]["trackName"],
        answer4: chosen_songs[3]["trackName"],
        correct_song: correct_song["trackName"]
      )
    end

    song = all_songs.sample
    artist = @current_user.create_artist(
      name: song["artistName"],
      image: song["artworkUrl100"],
    )
    redirect_to_with_ajax(new_keyword_path)
  end

  def destroy
    @question = Question.new
    Post.delete_all_questions(session[:user_id])
    render :new
  end
end
