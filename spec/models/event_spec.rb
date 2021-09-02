require 'rails_helper'

RSpec.describe Event, type: :model do

  it "全項目入力した場合は作成できる" do
    expect(FactoryBot.create(:event)).to be_valid
  end

  it "タイトルがなければ作成できない" do 
    expect(FactoryBot.build(:event, title: "")).to_not be_valid 
  end

  it "タイトルが21文字以上の場合は作成できない" do 
    expect(FactoryBot.build(:event, title: "123456789012345678901")).to_not be_valid 
  end 

  it "集合日時がなければ作成できない" do 
    expect(FactoryBot.build(:event, event_date: "")).to_not be_valid 
  end 

  it "コメントがなければ作成できない" do 
    expect(FactoryBot.build(:event, comment: "")).to_not be_valid 
  end

  it "コメントが101文字以上の場合は作成できない" do 
    expect(FactoryBot.build(:event, 
    comment: "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901")).to_not be_valid 
  end 

  it "募集人数がなければ作成できない" do 
    expect(FactoryBot.build(:event, recruting_count: "")).to_not be_valid 
  end 

  it "コースがなければ作成できない" do 
    expect(FactoryBot.build(:event, run_location: "")).to_not be_valid 
  end

  it "コースが21文字以上の場合は作成できない" do 
    expect(FactoryBot.build(:event, run_location: "123456789012345678901")).to_not be_valid 
  end 

  it "集合場所がなければ作成できない" do 
    expect(FactoryBot.build(:event, meeting_place: "")).to_not be_valid 
  end

  it "集合場所が21文字以上の場合は作成できない" do 
    expect(FactoryBot.build(:event, meeting_place: "123456789012345678901")).to_not be_valid 
  end 

  it "主催者IDがなければ作成できない" do 
    expect(FactoryBot.build(:event, owner_id: "")).to_not be_valid 
  end 


end