Rails.application.routes.draw do
  devise_for :users
  get 'user_data/index'
  get 'rekap/index'
  get 'sallary/index'
  get 'absent/index'
  get 'stock/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
    	post 'auth/token/request', to: 'authentications#request_token'
      post 'auth/forgot', to: 'authentications#forgot'
      
      get 'stock', to: 'stock#index'

      resource :employees, only:[] do
        get "/", to: "employee#index"
        get "/:id", to: "employee#show"

        post "/create", to: "employee#create"
        post "/update/:id", to: "employee#update"

        delete "/delete/:id", to: "employee#delete"
      end

      resource :stock, only:[] do
        get "/", to: "stock#index"
        get "/:id", to: "stock#show"

        post "/create", to: "stock#create"
        post "/update/:id", to: "stock#update"

        delete "/delete/:id", to: "stock#delete"
      end

      resource :absent, only:[] do
        get "/", to: "absent#index"

        post "/create", to: "absent#create"
        post "/update/:id", to: "absent#update"
      end
   	end
  end
end
