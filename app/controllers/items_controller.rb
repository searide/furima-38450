class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_item, only: :show

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  # def destroy
  #   item = Item.find(params[:id])
  #   item.destroy
  # end

  # def edit
  # end

  # def update
  #   item = Item.find(params[:id])
  #   item.update(item_params)
  # end

private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :delivery_cost_id, :prefecture_id, :delivery_date_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
