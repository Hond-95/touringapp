Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :user, only: [:show, :edit, :update] do
    member do
        get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  get "/home" => "event#home"
  resources :event, only: [:home, :new, :index , :search, :show, :edit, :chat, :create, :update, :destroy]
  post '/event/create' => 'event#create', as: 'event_create'
  get "search" => "event#search"
  get "chat/:id" => "event#chat" , as: 'event_chat'
  post 'participation/:id' => 'participation#create', as: 'create_participation'
  delete 'participation/:id' => 'participation#destroy', as: 'destroy_participation'
  resources :message
  post '/message/create' => 'message#create', as: 'message_create'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
