Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show, :create, :update, :destroy]
      # resources :merchants, only: [:index, :show, :create, :update, :destroy] do
      #   get '/:merchant_id/items', to: 'merchants#items_list'
      # end
      resources :items,  only: [:index, :show, :create, :update, :destroy]

      get '/merchants/:id/items', to: 'relationships#index'
      get '/items/:id/merchant', to:  'relationships#show'
    end
  end

end
