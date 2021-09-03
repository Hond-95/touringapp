require 'rails_helper'

RSpec.describe 'イベント詳細画面(モーダルウィンドウ)', type: :system, js: true do

  before do
    @user = FactoryBot.create(:user,:with_event)
    @user2 = FactoryBot.create(:user,:with_event)
    @user3 = FactoryBot.create(:user,:with_event)
  end

  it "イベント詳細情報が出力されていること" do
    sign_in @user
    visit home_path
    page.evaluate_script('$(".fade").removeClass("fade")')
    find_by_id('my_touring').click_on @user.events.first.title

    expect(find('.modal-title')).to have_content @user.events.first.title
    expect(find('.modal_event_date')).to have_content '日時: ' + @user.events.first.event_date.strftime("%Y年%m月%d日 %H時%M分")
    expect(find('.modal_run_location')).to have_content 'コース: ' + @user.events.first.run_location
    expect(find('.modal_meeting_place')).to have_content '集合場所: ' + @user.events.first.meeting_place
    expect(find('.modal_comment')).to have_content '詳細: ' + @user.events.first.comment
    expect(find('.modal_recruting_count')).to have_content '募集人数: ' + @user.events.first.recruting_count.to_s + '人'
    expect(find('.modal_participation_count')).to have_content '現在の参加人数: ' + @user.user_events.count.to_s + '人'
  end

  it "イベント主催者の場合には編集ボタンが表示されること" do
    sign_in @user
    visit home_path
    page.evaluate_script('$(".fade").removeClass("fade")')
    find_by_id('my_touring').click_on @user.events.first.title
    expect(find('.modal-footer')).to have_selector('a', text: '編集する')
  end

  it "イベント主催者でない場合には参加ボタンが表示されていること" do
    sign_in @user
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user2.events.first.id.to_s ).click_link @user2.events.first.title
    expect(find('.modal-footer')).to have_selector('a', text: '参加')
  end

  it "参加ボタン押下時にキャンセルボタンに切り替わること" do
    sign_in @user
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user2.events.first.id.to_s ).click_link @user2.events.first.title
    find('.modal-footer').click_link '参加'
    wait_for_ajax do
      expect(find('.modal-footer')).to have_selector('a', text: 'キャンセル')
    end
  end

  it "参加ボタン押下時に現在の参加人数が+1されること" do
    sign_in @user
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user2.events.first.id.to_s ).click_link @user2.events.first.title
    find('.modal-footer').click_link '参加'
    wait_for_ajax do
      expect(find('.modal_participation_count')).to have_content '現在の参加人数: 2人'
    end
  end

  it "キャンセルボタン押下時に参加ボタンに切り替わること" do
    sign_in @user
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user2.events.first.id.to_s ).click_link @user2.events.first.title
    find('.modal-footer').click_link '参加'
    wait_for_ajax
    find('.modal-footer').click_link 'キャンセル'
    wait_for_ajax do
      expect(find('.modal-footer')).to have_selector('a', text: '参加')
    end
  end

  it "キャンセルボタン押下時に現在の参加人数が-1されること" do
    sign_in @user
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user2.events.first.id.to_s ).click_link @user2.events.first.title
    find('.modal-footer').click_link '参加'
    wait_for_ajax
    find('.modal-footer').click_link 'キャンセル'
    wait_for_ajax do
      expect(find('.modal_participation_count')).to have_content '現在の参加人数: 1人'
    end
  end

  it "定員が埋まっている場合には「募集人数に達しました」が表示されること" do
    # @user2で@userのイベントに参加する
    sign_in @user2
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user.events.first.id.to_s ).click_link @user.events.first.title
    find('.modal-footer').click_link '参加'
    wait_for_ajax
    sign_out @user2

    # @user3で@user1のイベント詳細画面を開く
    sign_in @user3
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user.events.first.id.to_s ).click_link @user.events.first.title
    expect(find('.modal-footer')).to have_selector('a', text: '募集人数に達しました')
  end

end
