class Api::V1::RelationshipsController < ApplicationController

  def index
    merchant = Merchant.find(params[:id])
    render json: ItemSerializer.new(merchant.items.all)
  end
end