require 'rails_helper'

RSpec.describe 'ホーム画面', type: :system, js: true do

  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user,:with_event)
  end

  it "未ログイン時、ログイン画面に遷移すること" do 
    visit home_path
    expect(current_path).to eq new_user_session_path
  end

  it "ログイン時にホーム画面に遷移すること" do
    sign_in @user
    visit home_path
    expect(current_path).to eq home_path
  end

  it "「ツーリングを探す」ボタンを押下時、検索画面に遷移すること" do
    sign_in @user
    visit home_path
    click_on 'ツーリングを探す'
    expect(current_path).to eq event_index_path
  end

  it "「ツーリングを作成する」ボタンを押下時、新規イベント作成画面に遷移すること" do
    sign_in @user
    visit home_path
    click_on 'ツーリングを作成する'
    expect(current_path).to eq new_event_path
  end

  it "作成したツーリングがない時、「作ったツーリングはありません。」が表示されること" do
    sign_in @user
    visit home_path
    expect(page).to have_content '作ったツーリングはありません。'
  end

  it "参加予定のツーリングがない時、「参加予定のツーリングはありません。」が表示されること" do
    sign_in @user
    visit home_path
    expect(page).to have_content '参加予定のツーリングはありません。'
  end

  it "作成したツーリングがある時、表示されること" do
    sign_in @user2
    visit home_path
    expect(find_by_id('my_touring')).to have_selector('a', text: 'タイトルテスト')
  end

  it "参加予定のツーリングがある時、表示されること" do
    sign_in @user2
    visit home_path
    expect(find_by_id('event_index')).to have_selector('a', text: 'タイトルテスト')
  end

  it "作成欄の「編集する」を押下時、編集画面に遷移すること" do
    sign_in @user2
    visit home_path
    find_by_id('my_touring').click_link '編集する'
    expect(current_path).to eq edit_event_path(@user2.events.first.id)
  end

  it "「トークルーム」リンク押下時には、チャット画面に遷移すること" do
    sign_in @user2
    visit home_path
    find_by_id('event_index').click_link 'トークルーム'
    expect(current_path).to eq event_chat_path(@user2.events.first.id)
  end

  it "作ったツーリングのイベント名を押下時、モーダルが表示されること" do
    sign_in @user2
    visit home_path
    page.evaluate_script('$(".fade").removeClass("fade")')
    find_by_id('my_touring').click_on 'タイトルテスト'
    expect(page).to have_css('.modal-body')
  end

  it "参加予定のツーリングのイベント名を押下時、モーダルが表示されること" do
    sign_in @user2
    visit home_path
    page.evaluate_script('$(".fade").removeClass("fade")')
    find_by_id('event_index').click_on 'タイトルテスト'
    expect(page).to have_css('.modal-body')
  end

end