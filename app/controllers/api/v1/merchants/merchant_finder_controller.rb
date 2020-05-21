class Api::V1::Merchants::MerchantFinderController < ApplicationController

    def show
      merchant = Merchant.where("LOWER(name) like ?", "%#{merchant_params[:name].downcase}%")
      render json: MerchantSerializer.new(merchant[0])
    end

    private

      def merchant_params
        params.permit(:name)
      end
end
