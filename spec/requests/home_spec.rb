require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "Home Controller" do
    it "レスポンス正常確認" do
      get root_path
      expect(response).to be_successful
    end
  end
end
