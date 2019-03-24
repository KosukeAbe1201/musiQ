Rails.application.routes.draw do
  root "home#top"
  resources :sessions, only: [:create, :new]
  resource :session, only: [:destroy]
  resources :keywords, only: [:create, :new] do
    get :share, on: :collection
    get :top, on: :collection
    post :check_keyword, on: :collection
  end
  resources :answers, param: :question_num, only: [:create, :new, :show] do
    get :result, on: :collection
    post :next_question, on: :collection
  end
  resources :users, only: [:create, :new, :destroy]
  resources :posts, only: [:new, :create]
  post "post/destroy" => "posts#destroy"
end
