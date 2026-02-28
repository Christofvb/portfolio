FactoryBot.define do
  factory :skill do
    name { "Ruby on Rails" }
    skill_type { 1 } # framework
    image_path { nil }

    trait :language do
      name { "Ruby" }
      skill_type { 0 }
    end

    trait :tool do
      name { "Git" }
      skill_type { 2 }
    end
  end
end
