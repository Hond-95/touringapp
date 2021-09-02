require 'rails_helper'

RSpec.describe 'イベント編集画面', type: :system, js: true do

  before do
    @user = FactoryBot.create(:user,:with_event)
  end

  it "未ログイン時、ログイン画面に遷移すること" do 
    visit edit_event_path(@user.events.first.id)
    expect(current_path).to eq new_user_session_path
  end

  it "イベント名が未入力の場合は「イベント名を入力してください」が表示されること" do
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    fill_in "event[title]", with: ""
    fill_in "event[event_date]", with: DateTime.now + 1
    fill_in "event[comment]", with: "テスト"
    fill_in "event[recruting_count]", with: 1
    fill_in "event[run_location]", with: "テスト"
    fill_in "event[meeting_place]", with: "テスト"
    click_button '編集する'
    expect(page).to have_content 'イベント名を入力してください'
  end

  it "集合日時が未入力の場合は「集合日時を入力してください」が表示されること" do
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    fill_in "event[title]", with: "テスト"
    fill_in "event[event_date]", with: ""
    fill_in "event[comment]", with: "テスト"
    fill_in "event[recruting_count]", with: 1
    fill_in "event[run_location]", with: "テスト"
    fill_in "event[meeting_place]", with: "テスト"
    click_button '編集する'
    expect(page).to have_content '集合日時を入力してください'
  end

  it "コメントが未入力の場合は「コメントを入力してください」が表示されること" do
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    fill_in "event[title]", with: "テスト"
    fill_in "event[event_date]", with: DateTime.now + 1
    fill_in "event[comment]", with: ""
    fill_in "event[recruting_count]", with: 1
    fill_in "event[run_location]", with: "テスト"
    fill_in "event[meeting_place]", with: "テスト"
    click_button '編集する'
    expect(page).to have_content 'コメントを入力してください'
  end

  it "募集人数が未入力の場合は「募集人数を入力してください」が表示されること" do
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    fill_in "event[title]", with: "テスト"
    fill_in "event[event_date]", with: DateTime.now + 1
    fill_in "event[comment]", with: "テスト"
    fill_in "event[recruting_count]", with: ""
    fill_in "event[run_location]", with: "テスト"
    fill_in "event[meeting_place]", with: "テスト"
    click_button '編集する'
    expect(page).to have_content '募集人数を入力してください'
  end

  it "コースが未入力の場合は「コースを入力してください」が表示されること" do
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    fill_in "event[title]", with: "テスト"
    fill_in "event[event_date]", with: DateTime.now + 1
    fill_in "event[comment]", with: "テスト"
    fill_in "event[recruting_count]", with: 1
    fill_in "event[run_location]", with: ""
    fill_in "event[meeting_place]", with: "テスト"
    click_button '編集する'
    expect(page).to have_content 'コースを入力してください'
  end

  it "集合場所が未入力の場合は「集合場所を入力してください」が表示されること" do
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    fill_in "event[title]", with: "テスト"
    fill_in "event[event_date]", with: DateTime.now + 1
    fill_in "event[comment]", with: "テスト"
    fill_in "event[recruting_count]", with: 1
    fill_in "event[run_location]", with: "テスト"
    fill_in "event[meeting_place]", with: ""
    click_button '編集する'
    expect(page).to have_content '集合場所を入力してください'
  end

  it "集合日時が今日日付より前の場合は「集合日時は、明日以降の日付をしていしてください」が表示されること" do
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    fill_in "event[title]", with: "テスト"
    fill_in "event[event_date]", with: DateTime.now - 1
    fill_in "event[comment]", with: "テスト"
    fill_in "event[recruting_count]", with: 1
    fill_in "event[run_location]", with: "テスト"
    fill_in "event[meeting_place]", with: "テスト"
    click_button '編集する'
    expect(page).to have_content '集合日時は、明日以降の日付を指定してください。'
  end

  it "全項目入力されている場合、作成ボタン押下時にイベントが作成されていること" do
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    fill_in "event[title]", with: "テスト"
    fill_in "event[event_date]", with: DateTime.now + 1
    fill_in "event[comment]", with: "テスト"
    fill_in "event[recruting_count]", with: 1
    fill_in "event[run_location]", with: "テスト"
    fill_in "event[meeting_place]", with: "テスト"
    click_button '編集する'
    expect(page).to have_content 'ツーリングの編集を完了しました'
  end

  it "イベント作成失敗時、「ツーリングの編集に失敗しました」が表示されること" do
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    fill_in "event[title]", with: ""
    fill_in "event[event_date]", with: DateTime.now
    fill_in "event[comment]", with: ""
    fill_in "event[recruting_count]", with: ""
    fill_in "event[run_location]", with: ""
    fill_in "event[meeting_place]", with: ""
    click_button '編集する'
    expect(page).to have_content 'ツーリングの編集に失敗しました'
  end

  it "「ホーム画面に戻る」リンク押下時にホーム画面に遷移すること" do 
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    click_on 'ホーム画面に戻る'
    expect(current_path).to eq home_path
  end

  it "「削除する」リンク押下時にイベントが削除されること" do 
    sign_in @user
    visit edit_event_path(@user.events.first.id)
    click_on '削除する'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'ツーリングの削除を完了しました'
  end

end