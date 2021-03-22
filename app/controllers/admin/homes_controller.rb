class Admin::HomesController < ApplicationController

  def top
    @orders = Order.all.order(created_at: :desc)
    @params = params[:id]
    @order = Order.where(customer_id: @params)
  end
end
