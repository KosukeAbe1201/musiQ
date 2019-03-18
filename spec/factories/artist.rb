FactoryBot.define do
  factory :artist do
    name "artist"
    association :user
  end
end
