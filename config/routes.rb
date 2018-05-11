Rails.application.routes.draw do

  get "searchs/index" => "searchs#index"
  post "searchs/search" => "searchs#search"
  get "searchs/:tag_name" => "searchs#result"
  get "searchs/:tag_name/show" => "searchs#show"

  post "sees/:post_id/create" => "sees#create"
  post "sees/:post_id/destroy" => "sees#destroy"

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/index"  => "users#index"
  get "users/:id" => "users#show"
  get "users/:id/likes" => "users#likes"
  get "users/:id/sees" => "users#sees"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "login" => "users#login_form"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"



  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"


  get "/" => "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
