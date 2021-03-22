class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = OrderDetail.where(order_id: @order)
    @production_status = @order.order_details.pluck(:production_status)
    @select_order_status = order_status_validate(@order.order_status, @production_status)
    @select_product_status = product_status_validate()
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order)
    if @order.update(order_status_params)
      if @order.order_status.include?("入金確認")
         @order_details.update( production_status: 1)
      end
    flash[:success] = "制作ステータスを変更しました。"
    redirect_to admin_order_path(@order)
    else
      render "show"
    end
  end

  def order_status_validate(order_status,production_status)
    if order_status == 0
      return order_status.except(:"製作中",:"発送準備中",:"発送済み")
    end
  end

  def product_status_validate
  end


  private

  def order_status_params
    params.require(:order).permit(:order_status)
  end
end
