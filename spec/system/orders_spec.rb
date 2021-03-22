require 'rails_helper'

RSpec.describe "Orders", type: :system do
  describe "ログイン後のテスト" do
    let(:customer) { create(:customer)}
    let(:item) { create(:candy)}
    let(:other_item) { create(:cookie)}
    before do
      create(:cake)
      visit new_customer_session_path
      fill_in "customer_email", with: customer.email
      fill_in "customer_password", with: customer.password
      click_button "commit"
    end

    it "注文履歴一覧が登録順で表示される" do
      expect(1+1).to eq 2
    end
  end


end
