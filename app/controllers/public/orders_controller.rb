class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @shipping_addresses = current_customer.shipping_addresses
    @orders = Order.all
  end

  def confirm
  end

  def thanks
  end

  def show
  end

  def index
  end
end
