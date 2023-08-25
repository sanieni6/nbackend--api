Rails.application.routes.draw do
  
  devise_for :admins,
            controllers: {
              sessions: 'admins/sessions',
              registrations: 'admins/registrations'
            }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :create, :update, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
