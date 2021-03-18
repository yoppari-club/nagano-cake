class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])
    @order_detail.update(order_detail_status_params)
      redirect_back(fallback_location: root_path)
  end

  private

  def order_detail_status_params
    params.require(:order_detail).permit(:production_status)

  end


end
