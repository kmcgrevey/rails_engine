Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'merchant_finder#show'
      end
      
      resources :merchants, only: [:index, :show, :create, :update, :destroy]

      resources :items,  only: [:index, :show, :create, :update, :destroy]

      get '/merchants/:id/items', to: 'relationships#index'
      get '/items/:id/merchant', to:  'relationships#show'

    end
  end

end
