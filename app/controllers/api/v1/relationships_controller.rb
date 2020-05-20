class Api::V1::RelationshipsController < ApplicationController

  def index
    merchant = Merchant.find(params[:id])
    render json: ItemSerializer.new(merchant.items.all)
  end

  def show
    item = Item.find(params[:id])
    render json: MerchantSerializer.new(item.merchant)
  end
end