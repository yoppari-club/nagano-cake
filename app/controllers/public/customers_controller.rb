class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
    p @customer
  end

  def unsubscribe
  end

  def edit
  end
end
