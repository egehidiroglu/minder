Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # -------Content info----------
  resources :books, only: %i[index show]
  resources :movies, only: %i[index show]
  resources :musics, only: %i[index show]
  resources :summaries, only: %i[index]
  resources :creators, only: %i[index]

  # -------Creator info------------------------
  get '/my_creators', to: 'creators#my_creators', as: :my_creators
  get '/my_creators/new', to: 'creators#new'
  post '/my_creators', to: 'creators#create', as: :create_creator
  delete '/my_creators/:id', to: 'creators#destroy', as: :delete_creator

  # ------Profile setup - add Creators----------
  get '/artist_setup', to: 'creators#artist_setup', as: :artist_setup
  get '/director_setup', to: 'creators#director_setup', as: :director_setup
  get '/author_setup', to: 'creators#author_setup', as: :author_setup

  get '/auth/spotify/callback', to: 'users#spotify'
end
