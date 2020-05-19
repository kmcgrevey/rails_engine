class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create(body_params))
  end

  def update
    item = Item.find(params[:id])
    item.update(body_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    render json: ItemSerializer.new(Item.destroy(params[:id]))
  end

  private

    def body_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end
end