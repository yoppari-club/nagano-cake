class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = OrderDetail.where(order_id: @order)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order)
    if @order.update(order_status_params)
      if @order.order_status.include?("入金確認")
         @order_details.update( production_status: 1)
      end
    redirect_to admin_order_path(@order), notice: "You have updated order_status successfully."
    else
      render "show"
    end
  end

  private

  def order_status_params
    params.require(:order).permit(:order_status)
  end
end
