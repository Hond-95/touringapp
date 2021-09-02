FactoryBot.define do
  factory :event do
    title {"タイトルテスト"}
    event_date {DateTime.now + 1}
    comment {"コメントテスト"}
    recruting_count {2}
    run_location {"テストコース"}
    meeting_place {"東京駅"}
    owner_id {FactoryBot.create(:user).id}
  end

end
