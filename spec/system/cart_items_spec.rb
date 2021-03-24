require 'rails_helper'

RSpec.describe "CartItems", type: :system do
  describe "ログイン前のテスト" do
    it "カートページに行くと、rootに飛ばされる" do
      visit cart_items_path
      expect(current_path).to eq "/customers/sign_in"
    end
  end

  describe "ログイン後のテスト" do
    let(:customer) { create(:customer)}
    let(:item) { create(:candy)}
    let(:other_item) { create(:cookie)}

    before do
      create(:cake)
      visit new_customer_session_path
      fill_in "customer_email", with: customer.email
      fill_in "customer_password", with: customer.password
      click_button "ログイン"
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
      item_in_cart(item, 2)
      expect(page).to have_content "キャンディ"
      expect(page).to have_field "amount-number-field-1", with: 2
    end
    it "同一商品を追加した場合、新たなカートは生成されず、商品数が追加される" do
      item_in_cart(item, 2)
      item_in_cart(item, 3)
      expect(page).to have_content "カートに存在済のアイテムです"
      expect(page).to have_field "amount-number-field-1", with: 5
    end
    it "2製品追加した際に、カート内製品が2つ存在している" do
      item_in_cart(item, 2)
      item_in_cart(other_item, 3)
      expect(page).to have_field "amount-number-field-1", with: 2
      expect(page).to have_field "amount-number-field-2", with: 3
    end
    it "一つ製品追加後、その製品を削除すると、製品のないアナウンスが存在している" do
      item_in_cart(item, 2)
      click_link "cart-item-delete-1"
      expect(page).to have_content "カートに商品が入っておりません"
    end
    it "2つ製品追加後、カート内全削除を押すと、製品のないアナウンスが存在している" do
      item_in_cart(item, 2)
      item_in_cart(other_item, 3)
      click_link "all-delete"
      expect(page).to have_content "カートに商品が入っておりません"
    end
    it "2つ製品追加後、1つだけ消したらもう一方は残っている" do
      item_in_cart(item, 2)
      item_in_cart(other_item, 3)
      expect(page).to have_field "amount-number-field-1", with: 2
      expect(page).to have_content "キャンディ"
      click_link "cart-item-delete-1"
      expect(page).to have_content "クッキー"
      expect(page).to have_no_content "キャンディ"
      expect(page).to have_field "amount-number-field-1", with: 3
    end
    it "個数を変更した場合、反映されている" do
      item_in_cart(item, 2)
      fill_in "amount-number-field-1", with: 5
      click_button "amount-submit-1"
      expect(page).to have_field "amount-number-field-1", with: 5
    end
    it "買い物を続けるlinkを押すと、rootに行く" do
      visit cart_items_path
      click_link "買い物を続ける"
      expect(current_path).to eq "/"
    end
    it "情報入力へ進むlinkを押すと、orders/newに行く" do
      item_in_cart(item, 2)
      visit cart_items_path
      click_link "情報入力へ進む"
      expect(current_path).to eq "/orders/new"
    end
  end
end
