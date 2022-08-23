Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Change to my_creators for the route?
  resources :creators, only: %i[new, create, index, destroy] do
    resources :books, only: %i[index, show]
    resources :movies, only: %i[index, show]
    resources :musics, only: %i[index, show]
    resources :summaries, only: %i[index]
  end
end
