Gas::Application.routes.draw do
  #get "launches/show"
  resources :launches

  root :to => 'launches#new'
 
end
