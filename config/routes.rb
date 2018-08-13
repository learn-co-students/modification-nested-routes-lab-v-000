Rails.application.routes.draw do
  resources :artists, only: [:index, :show, :new, :create, :edit, :update] do
    resources :songs, only: [:index, :show, :new, :create, :edit, :update]
  end
  resources :songs
end
