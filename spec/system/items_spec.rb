require 'rails_helper'

RSpec.describe "Items", type: :system do

  describe "ログイン前のテスト" do
    let(:item) { create(:candy)}

    before do
      create(:cake)
      item
    end

    context "商品一覧ページ" do
      it "商品一覧画面に飛べる" do
        visit items_path
        expect(current_path).to eq "/items"
      end

      it "商品情報が表示されているかどうか" do
        visit items_path
        expect(page).to have_content item.name
        expect(page).to have_content item.price_excluding_tax
      end
    end

    context "商品詳細ページ" do
      it "商品詳細ページに飛べる" do
        visit item_path(item)
        expect(current_path).to eq "/items/1"
      end
      
      it "ログイン画面へ移動する" do
        visit item_path(item)
        click_button "カートに入れる"
        expect(current_path).to eq "/customers/sign_in"
      end
    end
  end
  
  describe "ログイン後のテスト" do
    let(:customer) { create(:customer)}
    let(:item) { create(:candy)}
    let(:other_item) { create(:cookie)}
    
    before do
      create(:cake)
      item
      visit new_customer_session_path
      fill_in "customer_email", with: customer.email
      fill_in "customer_password", with: customer.password
      click_button "ログイン"
    end
    
    context "商品詳細ページ" do
      it "商品をカート追加できる" do
        visit item_path(item)
        fill_in "個数を選択", with: 2
        click_button "カートに入れる"
        expect(current_path).to eq "/cart_items"
      end
    end
  end

end 
