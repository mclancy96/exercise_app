Rails.application.routes.draw do
  resources :routine_exercises
  resources :routines do
    member do
      get :workout, to: "workouts#show"
    end
  end
  resources :exercises
  root "application#home"

  # Defines the root path route ("/")
  # root "posts#index"
end
