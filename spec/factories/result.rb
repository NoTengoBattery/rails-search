FactoryBot.define do
  factory :result do
    extract { Faker::Food.dish }
    headline { Faker::Food.dish }
    mappings { {} }
    provider { Faker::Internet.domain_word }
    url { Faker::Internet.url }
  end
end
