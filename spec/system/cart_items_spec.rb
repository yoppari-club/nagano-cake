require 'rails_helper'

RSpec.describe "CartItems", type: :system do
  describe "ログイン前のテスト" do
    it "カートページに行くと、rootに飛ばされる" do
      visit cart_items_path
      expect(current_path).to eq "/customers/sign_in"
    end
  end

  describe "ログイン後のテスト" do
    let(:customer) { FactoryBot.create(:customer)}
    let(:item) { FactoryBot.create(:candy)}

    before do
      FactoryBot.create(:cake)
      visit new_customer_session_path
      fill_in "customer_email", with: customer.email
      fill_in "customer_password", with: customer.password
      click_button "commit"
    end

    it "カートページに行くと、カートページにいる" do
      visit cart_items_path
      expect(current_path).to eq "/cart_items"
    end
    it "商品追加前は製品が無いアナウンスがある" do
      visit cart_items_path
      expect(page).to have_content "カートに商品が入っておりません"
    end
    it "商品追加後はその商品がカートに入っている" do
      visit item_path(item)
      fill_in "cart_item_amount", with: 2
      click_button "commit"
      expect(page).to have_content "キャンディ"
      expect(page).to have_field "cart_item_amount", with: 2
    end
    it "同一商品を追加した場合、新たなカートは生成されず、商品数が追加される" do
      visit item_path(item)
      fill_in "cart_item_amount", with: 2
      click_button "commit"
      visit item_path(item)
      fill_in "cart_item_amount", with: 3
      click_button "commit"
      expect(page).to have_content "カートに存在済のアイテムです"
      expect(page).to have_field "cart_item_amount", with: 5
    end
  end
end
