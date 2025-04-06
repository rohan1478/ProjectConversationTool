FactoryBot.define do
    factory :project do
      title { Faker::Company.name }
      description { Faker::Lorem.paragraph }
      status { rand(0..2) }
    end
  end
