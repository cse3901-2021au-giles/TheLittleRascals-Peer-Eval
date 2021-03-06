Rails.application.routes.draw do
  resources :results
  resources :polls
  resources :teams
   get '/modify_team', to: 'teams#modify_team'
   post '/modify_team', to: 'teams#edit_team'
  resources :password, only: [:reset]
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]
   get '/password', to: 'password#reset'
   post 'emailpassword', to: 'password#send_email'
   get '/login', to: 'sessions#login'
   post '/login', to: 'sessions#create'
   post '/logout', to: 'sessions#destroy'
   get '/logout', to: 'sessions#destroy'
   match '/users/*all/edit', to: 'users#update', via: :post
  resources :students
  resources :projects
   get '/view-teams', to: 'teams#show_teams'
   get '/view-results', to: 'polls#show_polls'
   get '/view-single-result', to: 'polls#show_single_poll'
  match '*path' => redirect('/login'), via: :get
  match '/' => redirect('/login'), via: :get
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
