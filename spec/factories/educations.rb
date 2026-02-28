FactoryBot.define do
  factory :education do
    school     { "École 42" }
    degree     { "Développeur Web" }
    start_date { Date.new(2020, 9, 1) }
    end_date   { Date.new(2022, 6, 30) }
    description { nil }
  end
end
