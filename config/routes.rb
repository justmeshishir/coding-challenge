Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  post 'signup', to: 'users#signup', as: :signup
  get 'signin', to: 'users#signin', as: :signin

  resources :challenges, only: [:index, :create]

  get 'challenges/top', to: 'challenges#top_challenges', as: :top_challenge

  resources :answers, only: [:index, :create] do
    member do
      put 'upvote', to: 'answers#upvote'
      put 'downvote', to: 'answers#downvote'
    end
  end
end
