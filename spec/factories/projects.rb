FactoryBot.define do
  factory :project do
    name        { "Portfolio" }
    description { "Application portfolio Rails 8." }
    association :experience
  end
end
