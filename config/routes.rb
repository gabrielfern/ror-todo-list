Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  post '/tasks', to: 'tasks#create'
  put '/tasks/:id', to: 'tasks#update'
  post '/tasks/:id', to: 'tasks#update'
  put '/tasks/:id/switch', to: 'tasks#switch'
  delete '/tasks/:id', to: 'tasks#destroy'
  delete '/tasks', to: 'tasks#reset'

  get '/about', to: 'about#index'
end
