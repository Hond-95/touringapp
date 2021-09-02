FactoryBot.define do
  factory :message do
    message {"test message"}
    association :user
    association :event
  end
end