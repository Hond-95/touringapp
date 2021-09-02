FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test-#{n}"}
    sequence(:email) { |n| "test#{n}@example.com"}
    password {"password"}

    trait :with_user_info do
      after(:create) do |user|
        create(:user_info, user_id: user.id)
      end
    end
    
    trait :with_event do
      after(:create) do |user|
        create_list(:event, 1, owner_id: user.id, users: [user])
      end
    end

    trait :with_events do
      after(:create) do |user|
        create_list(:event, 7, owner_id: user.id, users: [user])
      end
    end

  end
end
