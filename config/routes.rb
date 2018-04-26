Rails.application.routes.draw do

  get "users/index"  => "users#index"
  get "users/:id" => "users#show"
  get "users/new" => "users#new"
  post "login" => "users#login"
  get "login" => "users#login_form"
  post "logout" => "users#logout"

  get "posts/index" => "posts#index"
  get "posts/:id" => "posts#show"

  get "/" => "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
