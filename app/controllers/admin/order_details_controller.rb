class Admin::OrderDetailsController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])
    if @order_detail.update(order_detail_status_params)
      if Order.where(id:@order).first.order_details.pluck(:production_status).include?("製作中")
         @order.order_status = 2
         @order.save
      elsif
        Order.where(id:@order).first.order_details.pluck(:production_status).all?{|status|status == "製作完了"}
        @order.order_status = 3
        @order.save
      end
    redirect_to admin_order_path(@order)
    else
      redirect_back(fallback_location: root_path)

    end
  end

  private

  def order_detail_status_params
    params.require(:order_detail).permit(:production_status)

  end


end
