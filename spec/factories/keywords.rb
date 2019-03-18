FactoryBot.define do
  factory :keyword do
    keyword "keyword"
    association :user

    to_create do |instance|
      instance.save validate: false
    end
  end
end
