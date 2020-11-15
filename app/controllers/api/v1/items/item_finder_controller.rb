class Api::V1::Items::ItemFinderController < ApplicationController
  
  def show
    item = Item.find_by("LOWER(#{item_params.keys[0]}) like ?", "%#{item_params.values[0].downcase}%")
    render json: ItemSerializer.new(item)
  end

  private

  def item_params
    params.permit(:name, :description)
  end
end