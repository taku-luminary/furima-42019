class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path

    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :image, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :days_to_ship_id).merge(user_id: current_user.id)
  end
end
