require 'rails_helper'

RSpec.describe 'トップページ', type: :system, js: true do

  before do
    @user = FactoryBot.create(:user)
  end

  it "未ログイン時にヘッダーリンク押下時にトップページに遷移すること" do
    visit root_path
    click_link 'brand-logo-header'
    expect(current_path).to eq root_path
  end

  it "未ログイン時にフッターリンク押下時にトップページに遷移すること" do
    visit root_path
    click_link 'brand-logo-footer'
    expect(current_path).to eq root_path
  end

  it "ログイン時にヘッダーリンク押下時にホーム画面に遷移すること" do
    sign_in @user
    visit home_path
    click_link 'brand-logo-header'
    expect(current_path).to eq home_path
  end

  it "ログイン時にフッターリンク押下時にホーム画面に遷移すること" do
    sign_in @user
    visit home_path
    click_link 'brand-logo-footer'
    expect(current_path).to eq home_path
  end

  it "ログインボタン押下時にログインページに遷移すること" do
    visit root_path
    click_on 'ログイン'
    expect(current_path).to eq new_user_session_path
  end

  it "新規登録ボタン押下時に新規登録ページに遷移すること" do
    visit root_path
    click_on '新規登録'
    expect(current_path).to eq new_user_registration_path
  end

  it "ログアウトリンク押下時にトップページに遷移すること" do
    sign_in @user
    visit home_path
    click_on 'ログアウト'
    expect(current_path).to eq root_path
  end

end