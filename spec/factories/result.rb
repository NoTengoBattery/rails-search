FactoryBot.define do
  factory :result do
    extract { Faker::Food.dish }
    headline { Faker::Food.dish }
    mappings { {} }
    url { Faker::Internet.url }
  end
end
