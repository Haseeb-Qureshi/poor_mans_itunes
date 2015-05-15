Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :index] do
    match 'make_admin' => 'users#make_admin', via: :patch
  end
  resource :session, only: [:create, :new, :destroy]
  resource :activation, only: [:edit]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:new, :index] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:new, :index] do
    resources :notes, only: [:create]
  end

  resources :notes, only: [:destroy]

  root to: "bands#index"
end
