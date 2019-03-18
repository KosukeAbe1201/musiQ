FactoryBot.define do
  factory :post do
    question "question"
    question_num 1
    correct_song "correct song"
    answer1 "answer1"
    answer2 "answer2"
    answer3 "answer3"
    answer4 "answer4"

    to_create do |instance|
      instance.save validate: false
    end
  end
end
