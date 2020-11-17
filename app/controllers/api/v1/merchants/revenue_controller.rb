class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    rev = Merchant.revenue(params[:id])
    render json: MerchantRevenueSerializer.new(rev)
  end
end