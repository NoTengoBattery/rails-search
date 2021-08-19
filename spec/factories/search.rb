FactoryBot.define do
  factory :search do
    engine { :google }
    search { Faker::Food.dish }
  end
end
