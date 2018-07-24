Rails.application.routes.draw do

  resources :artists do
    #nested resources for songs
    resources :songs, only: [:index, :show, :new]
  end

  resources :songs

  root 'songs#index'
end
