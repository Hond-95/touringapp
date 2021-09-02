require 'rails_helper'

RSpec.describe Message, type: :model do

  it "メッセージが入力されている場合は保存される" do
    expect(FactoryBot.create(:message)).to be_valid
  end

  it "メッセージが入力されていない場合は保存されない" do 
    expect(FactoryBot.build(:message, message: "")).to_not be_valid 
  end

end