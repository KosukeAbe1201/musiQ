FactoryBot.define do
  factory :user do
    name "Test User"
    password "password"

    to_create do |instance|
      instance.save validate: false
    end
  end
end
