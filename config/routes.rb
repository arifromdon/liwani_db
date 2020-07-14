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
        get "/show/:id", to: "stock#show"

        post "/create", to: "stock#create"
        post "/update/:id", to: "stock#update"

        delete "/delete/:id", to: "stock#delete"
      end

      resource :absent, only:[] do
        get "/", to: "absent#index"
        get "/show/:id", to: "absent#show"

        post "/create", to: "absent#create"
        post "/update/:id", to: "absent#update"
      end

      resource :salary, only:[] do
        get "/", to: "salary#index"
        get "/show/:id", to: "salary#show"

        post "/update/:id", to: "salary#update_salary"
        post "/update/cash_receipt/:id", to: "salary#update_cash_receipt"
      end

      resource :recap, only:[] do
        get "/", to: "recap#index"
        get "/export_salary", to: "recap#export_salary"

        post "/show_sallary", to: "recap#show_sallary"
        post "/show_stock", to: "recap#show_stock"
      end
   	end
  end
end
