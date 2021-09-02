require 'rails_helper'

RSpec.describe UserInfo, type: :model do

  it "全項目が入力されている場合は保存される" do
    expect(FactoryBot.create(:user_info)).to be_valid
  end

  it "年齢が空でも保存される" do 
    expect(FactoryBot.build(:user_info, age: "")).to be_valid 
  end

  it "性別が空でも保存される" do 
    expect(FactoryBot.build(:user_info, sex: "")).to be_valid 
  end

  it "乗ってるバイクが空でも保存される" do 
    expect(FactoryBot.build(:user_info, bike: "")).to be_valid 
  end

  it "好きなメーカーが空でも保存される" do 
    expect(FactoryBot.build(:user_info, touring_area: "")).to be_valid 
  end

  it "活動地域が空でも保存される" do 
    expect(FactoryBot.build(:user_info, favorite_maker: "")).to be_valid 
  end

end