Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # -------Content info----------
  resources :books, only: %i[index show]
  resources :movies, only: %i[index show]
  resources :musics, only: %i[index show]
  resources :summaries, only: %i[index]

  # -------Creator info----------
  get '/my_creators', to: 'creators#my_creators', as: :my_creators
  get '/my_creators/new', to: 'creators#new'
  post '/my_creators', to: 'creators#create'
  delete '/my_creators/:id', to: 'creators#destroy'

  get '/auth/spotify/callback', to: 'users#spotify'
  # ^Going to get it through current_user and get creators using through user_creators- current_user.creators
end
