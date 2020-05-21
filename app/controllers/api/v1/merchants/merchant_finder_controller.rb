class Api::V1::Merchants::MerchantFinderController < ApplicationController

    def show
      merchant = Merchant.find_by("LOWER(name) like ?", "%#{merchant_params[:name].downcase}%")
      render json: MerchantSerializer.new(merchant)
    end

    def index
      merchants = Merchant.where("LOWER(name) like ?", "%#{merchant_params[:name].downcase}%")
      render json: MerchantSerializer.new(merchants)
    end

    private

      def merchant_params
        params.permit(:name)
      end
end
