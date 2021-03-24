require 'rails_helper'

RSpec.describe Order, "Orderモデルに関するテスト", type: :model do
  before do
    FactoryBot.create(:customer)
  end

  describe "実際に保存" do
    it "有効なデータの保存" do
      expect(FactoryBot.build(:order)).to be_valid
    end

    context "空白のバリデーション" do
      it "total_paymentの空白" do
        expect(FactoryBot.build(:order, total_payment: "")).to be_invalid
      end
      it "payment_optionの空白" do
        expect(FactoryBot.build(:order, payment_option: "")).to be_invalid
      end
      it "shipping_feeの空白" do
        expect(FactoryBot.build(:order, shipping_fee: "")).to be_invalid
      end
      it "shipping_addressの空白" do
        expect(FactoryBot.build(:order, shipping_address: "")).to be_invalid
      end
      it "shipping_postcodeの空白" do
        expect(FactoryBot.build(:order, shipping_postcode: "")).to be_invalid
      end
      it "shipping_nameの空白" do
        expect(FactoryBot.build(:order, shipping_name: "")).to be_invalid
      end
      it "order_statusの空白" do
        expect(FactoryBot.build(:order, order_status: "")).to be_invalid
      end
    end

    context "郵便番号のバリデーション" do
      it "郵便番号が6桁" do
        expect(FactoryBot.build(:order, shipping_postcode: "011111")).to be_invalid
      end
      it "郵便番号が8桁" do
        expect(FactoryBot.build(:order, shipping_postcode: "01111111")).to be_invalid
      end
      it "郵便番号が文字" do
        expect(FactoryBot.build(:order, shipping_postcode: "墾田永年私財法")).to be_invalid
      end
    end

    context "配送先のバリデーション" do
      it "48文字の配送先住所" do
        expect(FactoryBot.build(:order, shipping_address: "a" * 48)).to be_valid
      end
      it "49文字の配送先住所" do
        expect(FactoryBot.build(:order, shipping_address: "a" * 49)).to be_invalid
      end
      it "32文字の配送先名" do
        expect(FactoryBot.build(:order, shipping_name: "a" * 32)).to be_valid
      end
      it "33文字の配送先名" do
        expect(FactoryBot.build(:order, shipping_name: "a" * 33)).to be_invalid
      end
    end
  end
end
