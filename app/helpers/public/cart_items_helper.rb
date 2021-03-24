module Public::CartItemsHelper

  def change_price_excluding_tax(price_excluding_tax)
    ((price_excluding_tax * 1.1).round(2)).round
  end
end
