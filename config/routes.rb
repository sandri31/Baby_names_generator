Rails.application.routes.draw do
  get 'home/new'

  get 'letters/:letter', to: 'letters#show', as: 'letter'

  # Defines the root path route ("/")
  root "home#new"
end
