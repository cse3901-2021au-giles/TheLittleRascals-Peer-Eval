Rails.application.routes.draw do
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]
   get '/login', to: 'sessions#login'
   post '/login', to: 'sessions#create'
   post '/logout', to: 'sessions#destroy'
   get '/logout', to: 'sessions#destroy' 
   match '/users/*all/edit', to: 'users#update', via: :post
  resources :students
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
