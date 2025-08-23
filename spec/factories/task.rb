FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "Task #{n}" }
    description { Faker::Lorem.sentence }
    status { "open" }
    association :list
  end
end