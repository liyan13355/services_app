Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create,:new, :edit, :update, :show, :index] do
  	resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]

  end

    
    root "welcome#index", as: "home"
    
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
