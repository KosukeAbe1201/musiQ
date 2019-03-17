class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :forbid_make_quiz, except: [:destroy]
  def new
  end

  def create
    all_songs = Post.search_songs(params[:post][:artist])
    if all_songs.size <= 20
      flash[:notice] = "クイズが作れませんでした。"
      render ("home/top")
      return
    end
    5.times do |i|
      correct_song = all_songs.sample
      answers = Post.get_answers(correct_song, all_songs)
      post = @current_user.posts.create(
        question: correct_song["previewUrl"],
        question_num: i+1,
        answer1: answers[0]["trackName"],
        answer2: answers[1]["trackName"],
        answer3: answers[2]["trackName"],
        answer4: answers[3]["trackName"],
        correct_song: correct_song["trackName"]
      )
    end
    song = all_songs.sample
    artist = @current_user.create_artist(
      name: song["artistName"],
      image: song["artworkUrl100"],
      user_id: session[:user_id]
    )
    respond_to do |format|
        format.html { redirect_to("/keywords/new") }
        format.js
    end
  end

  def destroy
    Post.delete_all_questions(session[:user_id])
    render("new")
  end
end
