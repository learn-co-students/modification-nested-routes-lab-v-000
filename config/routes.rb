Rails.application.routes.draw do
  resources :artists do
    resources :songs, only: [:index, :show, :new, :create, :update, :edit]
  end
  resources :songs
end
