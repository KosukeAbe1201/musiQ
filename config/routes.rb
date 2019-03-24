Rails.application.routes.draw do
  root "home#top"
  post "/update" => "answers#update"
  post "post/destroy" => "posts#destroy"
  get "/result" => "answers#result"
  get "/keyword" => "keywords#top"
  post "/keyword" => "keywords#check_keyword"
  get "/share" => "keywords#share"
  resources :sessions, only: [:create, :new]
  resource :session, only: [:destroy]
  resources :keywords, only: [:create, :new]
  resources :answers, param: :question_num
  resources :users, only: [:create, :new, :destroy]
  resources :posts, only: [:new, :create]
end
