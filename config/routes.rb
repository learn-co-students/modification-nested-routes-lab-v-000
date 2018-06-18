Rails.application.routes.draw do
  resources :artists do
    resources :songs, only: [:index, :show, :new, :edit, :update]
  end
  resources :songs
end
