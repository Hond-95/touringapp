require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { FactoryBot.create(:relationship) }
  describe '#create' do
    context "保存できる場合" do
      it "全てのパラメーターが揃っていれば保存できる" do
        expect(relationship).to be_valid
      end
    end

    context "保存できない場合" do
      it "follower_idがnilの場合は保存できない" do
        relationship.follower_id = nil
        expect(relationship).to_not be_valid
      end

      it "followed_idがnilの場合は保存できない" do
        relationship.following_id = nil
        expect(relationship).to_not be_valid
      end
    end

    context "一意性の検証" do
      before do
        @relation = FactoryBot.create(:relationship)
        @user1 = FactoryBot.build(:relationship)
      end
      it "follower_idとfollowing_idの組み合わせは一意でなければ保存できない" do
        relation2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id, following_id: @relation.following_id)
        expect(relation2).to_not be_valid
      end

      it "follower_idが同じでもfollowing_idが違うなら保存できる" do
        relation2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id, following_id: @user1.following_id)
        expect(relation2).to be_valid
      end

      it "follower_idが違うならfollowing_idが同じでも保存できる" do
        relation2 = FactoryBot.build(:relationship, follower_id: @user1.follower_id, following_id: @relation.following_id)
        expect(relation2).to be_valid
      end
    end
  end
end