class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(body_params))
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(body_params)
    render json: MerchantSerializer.new(merchant)
  end

  private

    def body_params
      params.permit(:name)
    end
end