Rails.application.routes.draw do
  resources :comments, only: [:show, :index]
end
