FactoryBot.define do
  factory :user_info do
    age { 20 }
    sex { true }
    bike { "bike" }
    touring_area { "touring_area" }
    favorite_maker { "favorite_maker" }
    user_id {FactoryBot.create(:user).id}
  end
end