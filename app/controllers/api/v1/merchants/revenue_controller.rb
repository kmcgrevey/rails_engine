class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    rev = Merchant.revenue(params[:id])
    render json: MerchantRevenueSerializer.new(rev)
  end

  def index
    list = Merchant.most_revenue(params['quantity'].to_i)
    render json: MerchantSerializer.new(list)
  end
end