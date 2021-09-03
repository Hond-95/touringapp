require 'rails_helper'

RSpec.describe 'プロフィール編集画面', type: :system, js: true do

  before do
    @user = FactoryBot.create(:user, :with_user_info)
  end

  it "未ログイン時にはログイン画面に遷移すること" do
    visit edit_user_path(@user.id)
    expect(current_path).to eq new_user_session_path
  end

  it "更新ボタン押下後にユーザー詳細画面に遷移すること" do
    sign_in @user
    visit edit_user_path(@user.id)
    click_button '更新'
    expect(current_path).to eq user_path(@user.id)
  end

  it "入力した内容で保存されること" do
    sign_in @user
    visit edit_user_path(@user.id)
    fill_in "user_info_age", with: 18
    find("option[value='true']").select_option
    fill_in "user_info_bike", with: "バイク"
    fill_in "user_info_favorite_maker", with: "HONDA"
    fill_in "user_info_touring_area", with: "東京"
    click_button '更新'
    expect(page).to have_content 'プロフィールの編集を完了しました'
  end


end