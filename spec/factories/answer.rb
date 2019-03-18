FactoryBot.define do
  factory :answer do
    name "names"
    correct 0

    to_create do |instance|
      instance.save validate: false
    end
  end
end
