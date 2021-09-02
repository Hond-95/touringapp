require 'rails_helper'

RSpec.describe 'イベント検索画面', type: :system, js: true do

  before do
    @user = FactoryBot.create(:user, :with_event)
  end

  it "未ログイン時、ログイン画面に遷移すること" do
    visit search_path
    expect(current_path).to eq new_user_session_path
  end

  it "キーワード入力して検索ボタン押下時に対象のイベントが表示されること" do
    sign_in @user
    visit search_path
    fill_in "keyword", with: "タイトル"
    click_button '検索'
    expect(all('.event_wrapper').size).to eq(1)
  end

  it "日時入力して検索ボタン押下時に対象のイベントが表示されること" do
    sign_in @user
    visit search_path
    fill_in "date", with: DateTime.now
    click_button '検索'
    expect(all('.event_wrapper').size).to eq(1)
  end

  it "キーワード・日時を入力後にクリアボタン押下時、入力した内容がクリアされること" do
    sign_in @user
    visit search_path
    fill_in "keyword", with: "タイトル"
    fill_in "date", with: DateTime.now
    click_button 'クリア'
    expect(find_by_id('keyword') && find_by_id('date')).to have_content ''
  end

  it "検索件数が7件以上の場合にはページネーションが表示されること" do
    create_list(:user, 6, :with_event)
    sign_in @user
    visit search_path
    click_button '検索'
    expect(page).to have_css('.page-item')
  end

  it "検索件数が7件未満の場合にはページネーションが表示されないこと" do
    sign_in @user
    visit search_path
    click_button '検索'
    expect(page).to have_no_css('.page-item')
  end

  it "検索後にイベント名を押下時にモーダルが表示されること" do
    sign_in @user
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_title').click_on 'タイトルテスト'
    expect(page).to have_css('.modal-body')
  end

end