Rails.application.routes.draw do
  get 'letters/:letter', to: 'letters#show', as: 'letter'
  get 'home/new'
  # Defines the root path route ("/")
  root 'home#description'
end
