require 'rails_helper'

RSpec.describe "Events", type: :request do
  let!(:user) { create(:user) }

  describe "GET /home" do
    context '未ログイン' do
      it '正常にレスポンスすること' do
        get root_path
        expect(response).to be_successful
      end
      it 'トップページに遷移すること' do
        get root_path
        should render_template('home/top')
      end
    end

    context 'ログイン中' do
      before do
        sign_in user
      end
      it '正常にレスポンスすること' do
        get root_path
        expect(response).to be_successful
      end
      it 'トップページに遷移すること' do
        get root_path
        should render_template('home/top')
      end
    end
  end
end
