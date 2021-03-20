require 'rails_helper'

RSpec.describe CartItem, "CartItemモデルに関するテスト", type: :model do
  before do
    FactoryBot.create(:cake)
    FactoryBot.create(:candy)
    FactoryBot.create(:customer)
  end

  describe "実際に保存してみる" do
    it "有効な物は保存可能か？" do
      cart_item = CartItem.new(item_id: 1,customer_id: 1,amount: 2)
      expect(cart_item).to be_valid
    end

    context "空白のバリデーションチェック" do
      it "個数が空白" do
        cart_item = CartItem.new(item_id: 1,customer_id: 1,amount: "")
        expect(cart_item).to be_invalid
        expect(cart_item.errors[:amount]).to include("is not a number")
      end
      it "item_idが空白" do
        expect(FactoryBot.build(:cart_item, item_id: "")).to be_invalid
      end
      it "customer_idが空白" do
        cart_item = CartItem.new(item_id: 1,customer_id: "",amount: 2)
        expect(cart_item).to be_invalid
      end
    end

    context "許可していない個数のバリデーションチェック" do
      it "個数に0を与える" do
        cart_item = CartItem.new(item_id: 1,customer_id: 1,amount: 0)
        expect(cart_item).to be_invalid
      end

      it "個数に-1を与える" do
        cart_item = CartItem.new(item_id: 1,customer_id: 1,amount: -1)
        expect(cart_item).to be_invalid
      end

      it "個数に1000を与える" do
        cart_item = CartItem.new(item_id: 1,customer_id: 1,amount: 1000)
        expect(cart_item).to be_invalid
      end

      it "個数に1.1を与える" do
        cart_item = CartItem.new(item_id: 1,customer_id: 1,amount: 1.1)
        expect(cart_item).to be_invalid
      end
    end
  end
end
