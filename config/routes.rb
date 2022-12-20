# frozen_string_literal: true

Rails.application.routes.draw do
  get 'letters/:letter', to: 'letters#show', as: 'letter'
  get 'baby_names', to: 'baby_names#baby_names'
  get 'home/new'
  # Defines the root path route ("/")
  root 'home#description'
end
