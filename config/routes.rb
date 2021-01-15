Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'games#new'
  # get 'new', to: 'games#new', as: :new # extra :)
  post 'score', to: 'games#score', as: :score
  get 'score', to: 'games#score', as: :score_get
end
