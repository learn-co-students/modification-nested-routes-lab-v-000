Rails.application.routes.draw do
  resources :artists do
    resources :songs, only: [:index, :show, :create, :new, :edit]
  end
  resources :songs
end
