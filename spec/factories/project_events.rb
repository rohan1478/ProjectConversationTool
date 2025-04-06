FactoryBot.define do
    factory :project_event do
      project
      user
      event_type { Faker::Lorem.word }
      content { Faker::Lorem.sentence }
      old_status { 'pending' }
      new_status { 'completed' }
    end
  end
