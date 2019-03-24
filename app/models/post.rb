require 'itunes_search_api'
class Post < ApplicationRecord
  validates :question, { presence: true }
  validates :answer1, { presence: true }
  validates :answer2, { presence: true }
  validates :answer3, { presence: true }
  validates :answer4, { presence: true }

  scope :return_posts_num, ->(params) { where(user_id: params).count }

  DUMMY_SONGS_NUM = 3

  def self.fetch_songs_from_itunes_api(artist)
    ITunesSearchAPI.search(
        :term    => artist,
        :country => "jp",
        :media   => 'music',
        :lang    => 'ja_jp',
        :attribute => "artistTerm",
        :limit  => '200'
        )
  end

  def self.choose_four_songs(correct_song, all_songs)　#ダミーの3曲と正解の1曲を含む配列を返す
    song_list = DUMMY_SONGS_NUM.times.map do
      dummy_song = all_songs.sample
      all_songs.delete(dummy_song)
      dummy_song
    end
    song_list << correct_song
    song_list.shuffle
  end

  def self.delete_all_questions(user_id)
    Post.where(user_id: user_id).delete_all
    Keyword.where(user_id: user_id).delete_all
    Answer.where(user_id: user_id).delete_all
    Artist.where(user_id: user_id).delete_all
  end
end
