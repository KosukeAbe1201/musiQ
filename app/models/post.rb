require 'itunes_search_api'
class Post < ApplicationRecord
  validates :question, { presence: true }
  validates :answer1, { presence: true }
  validates :answer2, { presence: true }
  validates :answer3, { presence: true }
  validates :answer4, { presence: true }

  scope :return_posts_num, ->(params) { where(user_id: params).count }

  def self.search_songs(artist)
      ITunesSearchAPI.search(
          :term    => artist,
          :country => "jp",
          :media   => 'music',
          :lang    => 'ja_jp',
          :attribute => "artistTerm",
          :limit  => '200'
          )
  end

  def self.get_answers(correct_song, all_songs)
    arr = 3.times.map do
      song = all_songs.sample
      all_songs.delete(song)
      song
    end
    arr << correct_song
    arr.shuffle
  end

  def self.delete_all_questions(user_id)
    Post.where(user_id: user_id).delete_all
    Keyword.where(user_id: user_id).delete_all
    Answer.where(user_id: user_id).delete_all
    Artist.where(user_id: user_id).delete_all
  end
end
