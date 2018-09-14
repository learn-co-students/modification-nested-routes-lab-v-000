Rails.application.routes.draw do
  resources :artists do
    resources :songs, only: [:show, :index, :show, :new, :edit]
  end
  resources :songs, only: [:index, :show, :new, :create, :edit, :update]


  root 'songs#index'
end
