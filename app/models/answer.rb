class Answer < ApplicationRecord
  validates :name, { presence: true, uniqueness: true }
  scope :update_correct_num, ->(name, answer) { find_by(name: name).update(correct: answer.correct += 1) }
  scope :find_answer_by_name, ->(params) { find_by(name: params) }
  def self.search_post(question_num, user_id)
    Post.find_by(question_num: question_num ,user_id: user_id)
  end

  def self.search_user(id)
    User.find_by(id: id)
  end

  def self.search_keyword(user_id)
    Keyword.find_by(user_id: user_id)
  end

  def self.search_artist(user_id)
    Artist.find_by(user_id: user_id)
  end

  def self.search_message(int)
    case int
    when (0..1) then
      "残念。まだまだですね。"
    when (2..3) then
      "ふーん、まあまあですね。"
    when 4 then
      "おしい、あと1問で満点です"
    when 5 then
      "素晴らしい！満点です！"
    end
  end
end
