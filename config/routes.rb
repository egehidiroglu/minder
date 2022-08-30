Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # -------Content info----------
  resources :books, only: %i[index show]
  resources :movies, only: %i[index show]
  resources :musics, only: %i[index show]
  resources :summaries, only: %i[index]
  resources :creators, only: %i[index]

  # -------Creator info----------
  get '/my_creators', to: 'creators#my_creators', as: :my_creators
  get '/my_creators/new', to: 'creators#new'
  post '/my_creators', to: 'creators#create', as: :create_creator
  delete '/my_creators/:id', to: 'creators#destroy', as: :delete_creator

  # ------Profile setup - add Creators----------
  get '/artist_setup', to: 'creators#artist_setup', as: :artist_setup

  get '/director_setup', to: 'creators#director_setup', as: :director_setup

  get '/author_setup', to: 'creators#author_setup', as: :author_setup

  # -----------For the add button (works for all three)--------------
  post '/artist_setup', to: 'creators#create_followed_creator', as: :create_followed_creator

  get '/auth/spotify/callback', to: 'users#spotify'
  # ^Going to get it through current_user and get creators using through user_creators- current_user.creators

  # -------Favorite Content -----

  post '/favorite_movies/:id', to: 'movies#favorite_movie', as: :favorite_movie
  get '/favorite_music/:id', to: 'musics#favorite_music', as: :favorite_music
  get '/favorite_books/:id', to: 'books#favorite_book', as: :favorite_book
  get '/my_favorites', to: 'users#my_favorites', as: :user_favorites
  get '/favorite_content/:id', to: 'users#unfavorite', as: :unfavorite
  post '/favorite_something/:id', to: 'users#custom_unfav', as: :custom_unfav
end
