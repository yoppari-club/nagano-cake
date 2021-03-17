class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).reverse_order 
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    
  end
  
  def update
  end  

  private
  def item_params
    params.require(:item).permit(:image_id, :name, :description, :genre, :price_excluding_tax, :sales_status)
  end
    
end
