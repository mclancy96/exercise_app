Rails.application.routes.draw do
  resources :routine_exercises
  resources :routines
  resources :exercises
 root "application#home"

  # Defines the root path route ("/")
  # root "posts#index"
end
