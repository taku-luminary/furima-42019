class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:edit]
  before_action :set_item, only: [:show, :edit, :update, :move_to_index]

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
    @user = @item.user
  end

  def edit
    @user = @item.user
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :image, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :days_to_ship_id).merge(user_id: current_user.id)
  end

  def move_to_index
    return if current_user.id == @item.user_id

    redirect_to action: :index
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
