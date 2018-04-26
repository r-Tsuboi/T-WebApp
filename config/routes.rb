Rails.application.routes.draw do

  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/index"  => "users#index"
  get "users/:id" => "users#show"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "login" => "users#login_form"



  get "posts/index" => "posts#index"
  get "posts/:id" => "posts#show"

  get "/" => "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
