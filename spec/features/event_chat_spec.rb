require 'rails_helper'

RSpec.describe 'チャット画面', type: :system, js: true do

  before do
    @user = FactoryBot.create(:user,:with_event)
    @user2 = FactoryBot.create(:user,:with_event)
  end

  it "未ログイン時、ログイン画面に遷移すること" do
    visit event_chat_path(@user.events.first.id)
    expect(current_path).to eq new_user_session_path
  end

  it "参加者一覧が表示されること" do
    sign_in @user2
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user.events.first.id.to_s ).click_link @user.events.first.title
    find('.modal-footer').click_link '参加'
    wait_for_ajax
    sign_out @user2

    sign_in @user
    visit event_chat_path(@user.events.first.id)
    expect(page).to  have_selector('a', text: @user.name )
    expect(page).to  have_selector('a', text: @user2.name )
  end

  it "参加者一覧のユーザー名を押下時、対象のユーザー詳細画面に遷移すること" do
    # @user2で@userのイベントに参加
    sign_in @user2
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user.events.first.id.to_s ).click_link @user.events.first.title
    find('.modal-footer').click_link '参加'
    wait_for_ajax
    sign_out @user2

    sign_in @user
    visit event_chat_path(@user.events.first.id)
    find("a", :text => @user2.name ).click
    expect(current_path).to eq user_path(@user2.id)  
  end

  it "チャット投稿欄にメッセージ入力後にエンターキーを押下して、メッセージが表示されること" do
    # @user2で@userのイベントに参加
    sign_in @user2
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user.events.first.id.to_s ).click_link @user.events.first.title
    find('.modal-footer').click_link '参加'
    wait_for_ajax
    sign_out @user2

    sign_in @user
    visit event_chat_path(@user.events.first.id)
    fill_in 'メッセージを入力' , with: 'メッセージ１'
    find("#content").send_keys :return
    expect(page).to have_content 'メッセージ１'
    expect(find('.message-info')).to have_content @user.name
    expect(find('.message-info')).to have_content @user.messages.first.created_at.strftime("%m/%d %H:%M").to_s
  end

  it "自分が投稿したメッセージは送信者用の枠であること" do
    # @user2で@userのイベントに参加
    sign_in @user2
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user.events.first.id.to_s ).click_link @user.events.first.title
    find('.modal-footer').click_link '参加'
    wait_for_ajax
    sign_out @user2

    sign_in @user
    visit event_chat_path(@user.events.first.id)
    fill_in 'メッセージを入力' , with: 'メッセージ１'
    find("#content").send_keys :return
    expect(page).to have_css('.message-sender')
  end

  it "自分が投稿したメッセージは受信者用の枠であること" do
    # @user2で@userのイベントに参加しトークルームでメッセージを送信
    sign_in @user2
    visit search_path
    click_button '検索'
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_' + @user.events.first.id.to_s ).click_link @user.events.first.title
    find('.modal-footer').click_link '参加'
    wait_for_ajax
    visit event_chat_path(@user.events.first.id)
    fill_in 'メッセージを入力' , with: 'メッセージ2'
    find("#content").send_keys :return
    sign_out @user2

    sign_in @user
    visit event_chat_path(@user.events.first.id)
    expect(page).to have_content 'メッセージ2'
    expect(page).to have_css('.message-receiver')
  end


end