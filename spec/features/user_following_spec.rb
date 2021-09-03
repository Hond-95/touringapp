require 'rails_helper'

RSpec.describe 'フォロー一覧画面', type: :system, js: true do

  before do
    @user = FactoryBot.create(:user, :with_user_info)
    @user2 = FactoryBot.create(:user, :with_user_info)
  end

  it "未ログイン時にはログイン画面に遷移すること" do
    visit following_user_path(@user.id)
    expect(current_path).to eq new_user_session_path
  end

  it "対象のユーザー名が表示されること" do
    sign_in @user
    visit following_user_path(@user.id)
    expect(find('.profile-name')).to have_selector('h3', text: @user.name)
  end

  it "フォロー中のユーザー数が表示されること" do
    sign_in @user
    visit user_path(@user2.id)
    find_by_id('follow_form').click_on 'フォローする'
    wait_for_ajax
    visit following_user_path(@user.id)
    expect(find('.following_count')).to have_selector('strong', count: @user.following.count )
  end

  it "フォロワーのユーザー数が表示されること" do
    # @user2で@userをフォローする
    sign_in @user2
    visit user_path(@user.id)
    find_by_id('follow_form').click_on 'フォローする'
    wait_for_ajax
    sign_out @user2

    # @userのフォロワー数を確認
    sign_in @user
    visit following_user_path(@user.id)
    expect(find('.follower_count')).to have_selector('strong', count: @user.followers.count )
  end

  it "フォロー中のユーザー一覧が表示されること" do
    sign_in @user
    # 先に@user2をフォローする
    visit user_path(@user2.id)
    find_by_id('follow_form').click_on 'フォローする'
    wait_for_ajax

    visit following_user_path(@user.id)
    # フォロー中のユーザー名・バイク名とフォロー解除ボタンが表示されること
    expect(find('.index-name')).to have_selector('a', text: @user2.name )
    expect(find('.index-name')).to have_selector('span', text: '|' + @user2.user_info.bike )
    expect(find('.index-follow')).to have_button 'フォロー解除'
  end

  it "ユーザー名を押下時にユーザー詳細画面に遷移すること" do
    sign_in @user
    # 先に@user2をフォローする
    visit user_path(@user2.id)
    find_by_id('follow_form').click_on 'フォローする'
    wait_for_ajax

    visit following_user_path(@user.id)
    click_link @user2.name
    expect(current_path).to eq user_path(@user2.id)
  end

  it "フォロー解除ボタン押下時にフォローボタン位切り替わり、フォロー数が減ること" do
    sign_in @user
    # 先に@user2をフォローする
    visit user_path(@user2.id)
    find_by_id('follow_form').click_on 'フォローする'
    wait_for_ajax

    visit following_user_path(@user.id)
    find('.index-follow').click_button 'フォロー解除'
    wait_for_ajax do
      expect(find('.index-follow')).to have_button 'フォローする'
      expect(find('.following_count')).to have_selector('strong', count: 0 )
    end
  end

  it "フォローボタン押下時にフォロー解除ボタンに切り替わり、フォロー数が増えること" do
    sign_in @user
    # 先に@user2をフォローする
    visit user_path(@user2.id)
    find_by_id('follow_form').click_on 'フォローする'
    wait_for_ajax

    visit following_user_path(@user.id)
    find('.index-follow').click_button 'フォロー解除'
    wait_for_ajax do
      expect(find('.index-follow')).to have_button 'フォローする'
      expect(find('.following_count')).to have_selector('strong', count: 0 )
    end

    find('.index-follow').click_button 'フォローする'
    wait_for_ajax do
      expect(find('.index-follow')).to have_button 'フォロー解除'
      expect(find('.following_count')).to have_selector('strong', count: 1 )
    end
  end

end