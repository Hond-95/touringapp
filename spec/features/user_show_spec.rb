require 'rails_helper'

RSpec.describe 'ユーザー詳細画面', type: :system, js: true do

  before do
    @user = FactoryBot.create(:user, :with_event, :with_user_info)
    @user2 = FactoryBot.create(:user, :with_events)
  end

  it "未ログイン時、ログイン画面に遷移すること" do
    visit user_path(@user.id)
    expect(current_path).to eq new_user_session_path
  end

  it "ユーザ名が表示されること" do
    sign_in @user
    visit user_path(@user.id)
    expect(find('.profile-icon h2')).to have_content @user.name
  end

  it "プロフィールの更新日時が表示されること" do
    sign_in @user
    visit user_path(@user.id)
    expect(find_by_id('update-day')).to have_content @user.user_info.updated_at.strftime("%Y.%m.%d %H:%M") + ' 更新'
  end

  it "年齢が表示されること" do
    sign_in @user
    visit user_path(@user.id)
    expect(find('.user_age')).to have_content @user.user_info.age
  end

  it "性別が表示されること" do
    sign_in @user
    visit user_path(@user.id)
    expect(find('.user_sex')).to have_content '男性'
  end

  it "乗っているバイクが表示されること" do
    sign_in @user
    visit user_path(@user.id)
    expect(find('.user_bike')).to have_content @user.user_info.bike
  end

  it "好きなメーカーが表示されること" do
    sign_in @user
    visit user_path(@user.id)
    expect(find('.user_favorite_maker')).to have_content @user.user_info.favorite_maker
  end

  it "活動地域が表示されること" do
    sign_in @user
    visit user_path(@user.id)
    expect(find('.user_touring_area')).to have_content @user.user_info.touring_area
  end

  it "年齢が登録されていない場合、「未登録」と表示されること" do
    sign_in @user2
    visit user_path(@user2.id)
    expect(find('.user_age')).to have_content '未登録'
  end

  it "性別が登録されていない場合、「未登録」と表示されること" do
    sign_in @user2
    visit user_path(@user2.id)
    expect(find('.user_sex')).to have_content '未登録'
  end

  it "乗っているバイクが登録されていない場合、「未登録」と表示されること" do
    sign_in @user2
    visit user_path(@user2.id)
    expect(find('.user_bike')).to have_content '未登録'
  end

  it "好きなメーカーが登録されていない場合、「未登録」と表示されること" do
    sign_in @user2
    visit user_path(@user2.id)
    expect(find('.user_favorite_maker')).to have_content '未登録'
  end

  it "活動地域が登録されていない場合、「未登録」と表示されること" do
    sign_in @user2
    visit user_path(@user2.id)
    expect(find('.user_touring_area')).to have_content '未登録'
  end

  it "参加予定のイベントが表示されること" do
    sign_in @user2
    visit user_path(@user2.id)
    expect(all('.event_wrapper').size).to eq(6)
  end

  it "参加予定のイベント名を押下時にモーダルが表示されること" do
    sign_in @user
    visit user_path(@user.id)
    page.evaluate_script('$(".fade").removeClass("fade")')
    find('.event_title').click_on 'タイトルテスト'
    expect(page).to have_css('.modal-body')
  end

  it "モーダルの件数が7件以上の場合にはページネーションが表示されること" do
    sign_in @user2
    visit user_path(@user2.id)
    expect(page).to have_css('.page-item')
  end

  it "モーダルの件数が7件未満の場合にはページネーションが表示されないこと" do
    sign_in @user
    visit user_path(@user.id)
    expect(page).to have_no_css('.page-item')
  end

  it "自分のユーザー詳細画面にはフォローボタンが表示されないこと" do
    sign_in @user
    visit user_path(@user.id)
    expect(page).to_not have_css('follow_form')
  end

  it "自分のユーザー詳細画面にはプロフィール編集リンクが表示されること" do
    sign_in @user
    visit user_path(@user.id)
    expect(page).to have_css('.profile-edit-link')
  end

    it "自分以外のユーザー詳細画面にはフォロワーがフォローボタンが表示されること" do
      sign_in @user
      visit user_path(@user2.id)
      expect(find_by_id('follow_form')).to have_button 'フォローする'
    end

  it "自分以外のユーザー詳細画面にはプロフィール編集リンクが表示されないこと" do
    sign_in @user
    visit user_path(@user2.id)
    expect(page).to_not have_css('.profile-edit-link')
  end

  it "プロフィール編集リンク押下時にプロフィール編集画面に遷移すること" do
    sign_in @user
    visit user_path(@user.id)
    find('.profile-edit-link').click_link 'プロフィール編集'
    expect(current_path).to eq edit_user_path(@user.id)
  end

  it "フォロー中リンク押下時にフォロー一覧画面に遷移すること" do
    sign_in @user
    visit user_path(@user.id)
    find_by_id('follow_count').click_link 'フォロー中'
    expect(current_path).to eq following_user_path(@user.id)
  end

  it "フォロワーリンク押下時にフォロワー一覧画面に遷移すること" do
    sign_in @user
    visit user_path(@user.id)
    find_by_id('follow_count').click_link 'フォロワー'
    expect(current_path).to eq followers_user_path(@user.id)
  end

  it "フォローボタン・フォロー解除ボタン押下時にフォロー・フォロー解除できること" do
    sign_in @user
    visit user_path(@user2.id)

    # @user2をフォローする
    find_by_id('follow_form').click_on 'フォローする'
    wait_for_ajax do
      expect(find_by_id('follow_form')).to have_button 'フォロー解除'
      expect(@user.following.count).to eq(1)
      expect(@user2.followers.count).to eq(1)
      expect(find('.follower_count')).to have_selector('strong', count: 1 )
    end

    # @user2をフォロー解除する
    find_by_id('follow_form').click_on 'フォロー解除'
    wait_for_ajax do
      expect(find_by_id('follow_form')).to have_button 'フォローする'
      expect(@user.following.count).to eq(0)
      expect(@user2.followers.count).to eq(0)
      expect(find('.follower_count')).to have_selector('strong', count: 0 )
    end
  end


end