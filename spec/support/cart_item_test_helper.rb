module CartItemTestHelper
  def item_in_cart(item, amount)
    visit item_path(item)
    fill_in "cart_item_amount", with: amount
    click_button "カートに入れる"
  end
end