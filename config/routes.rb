require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'movies#index'
  get '/movies/top', to: 'movies#top'

  resources :movies, only: %i[show], param: :title
end
