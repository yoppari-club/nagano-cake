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
      it "商品詳細を選択できる" do
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
end
