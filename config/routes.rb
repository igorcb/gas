Gas::Application.routes.draw do
  match '/report', to: 'static_pages#report'

  get "static_pages/listing_launches"
  match '/listing_launches_per_year', :controller=>'static_pages', :action => 'listing_launches_per_year'
  resources :launches

  root :to => 'launches#new'
 
end
