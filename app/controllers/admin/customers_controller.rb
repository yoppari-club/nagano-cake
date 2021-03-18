class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    
  end

  def show
    @customer = Customer.find_by(params[:id])
  end

  def edit
    @customer = Customer.find_by(params[:id])
  end
  
  def update
    @customer = Customer.find_by(params[:id])
    p "----------"
    p @customer
    @customer.update(customer_params)
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :tel, :email, :withdrawal_status)
  end
end
