class Api::V1::Merchants::MerchantFinderController < ApplicationController

  def show
    if merchant_params[:name]
      merchant = Merchant.find_by("LOWER(name) like ?", "%#{merchant_params[:name].downcase}%")
    elsif merchant_params[:created_at]
      dat = Date.parse(merchant_params[:created_at])
      merchant = Merchant.where(created_at: dat.beginning_of_day...dat.end_of_day).first
    elsif merchant_params[:updated_at]
      dat = Date.parse(merchant_params[:updated_at])
      merchant = Merchant.where(updated_at: dat.beginning_of_day...dat.end_of_day).first
    end
    render json: MerchantSerializer.new(merchant)
  end

  def index
    merchants = Merchant.where("LOWER(name) like ?", "%#{merchant_params[:name].downcase}%")
    render json: MerchantSerializer.new(merchants)
  end

  private

    def merchant_params
      params.permit(:name, :created_at, :updated_at)
    end
end
