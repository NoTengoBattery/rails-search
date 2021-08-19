FactoryBot.define do
  factory :search do
    engine { Search::ENGINES.sample }
    search { Faker::Food.dish }
    results { [] }
  end
end
