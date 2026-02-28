FactoryBot.define do
  factory :experience do
    job_title { "Développeur Web" }
    company   { "Acme Corp" }
    location  { "Paris, France" }
    start_date { Date.new(2022, 1, 1) }
    end_date   { nil }
    missions  { nil }
    tools     { nil }
  end
end
