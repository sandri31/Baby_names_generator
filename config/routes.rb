Rails.application.routes.draw do
  get 'letters/:letter', to: 'letters#show', as: 'letter'

  # Defines the root path route ("/")
  root "home#description"
end
