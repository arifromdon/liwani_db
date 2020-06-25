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
        
        get 'stock', to: 'stock#index'
   	end
  end
end
