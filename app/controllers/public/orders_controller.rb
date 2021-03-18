class Public::OrdersController < ApplicationController
  include Public::OrdersHelper
  before_action :authenticate_customer!
  before_action :cart_check, only: [:new, :confirm, :create]

  def cart_check
    unless CartItem.find_by(customer_id: current_customer.id)
      flash[:danger] = "カートに商品がない状態です"
      redirect_to root_url
    end
  end

  def new
    @order = Order.new
    @shipping_addresses = current_customer.shipping_addresses
  end

  def confirm
    @order = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
    customer = current_customer
    address_option = params[:order][:address_option].to_i

    @order.payment_option = params[:order][:payment_option].to_i
    if address_option == 0
      @order.order_in_postcode_address_name(customer.postcode, customer.address, customer.last_name)
    elsif address_option == 1
      shipping = ShippingAddress.find(params[:order][:registration_shipping_address])
      @order.order_in_postcode_address_name(shipping.shipping_postcode, shipping.shipping_address, shipping.shipping_name)
    elsif address_option == 2
      if params[:order][:shipping_postcode].blank? || params[:order][:shipping_address].blank? || params[:order][:shipping_name].blank?
        flash[:danger] = "新しいお届け先の内容に不備があります"
        redirect_back(fallback_location: root_path)
      end
      @order.order_in_postcode_address_name(params[:order][:shipping_postcode], params[:order][:shipping_address], params[:order][:shipping_name])
    else
    end
    # render plain: @order.inspect
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_fee = 800
    if @order.save
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price_including_tax = change_price_excluding_tax(cart_item.item.price_excluding_tax)
        order_detail.production_status = 0
        if order_detail.save
          @cart_items.destroy_all
        end
      end
      redirect_to orders_thanks_path
    else
    end
  end

  def thanks
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  private

  def order_params
    params.require(:order).permit(:shipping_postcode, :shipping_address, :shipping_name, :total_payment, :payment_option)
  end

end
