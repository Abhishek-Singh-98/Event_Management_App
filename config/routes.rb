Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # 
  #
  resources :users do
    resources :events do
      post 'rsvping_events', to: "events#rsvp_events"
      patch 'update_rsvp', to: "events#update_rsvp"
    end
  end

  resources :categories do
    get 'filter_event', to: "categories#filter_by_category"
  end
end
