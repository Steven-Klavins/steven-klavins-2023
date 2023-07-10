require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, :skip => [:sessions]

  # Authentication for Sidekiq activity panel
  devise_scope :user do
    authenticated :user do
      mount Sidekiq::Web => "/sidekiq"
      get '/admin-panel', to: 'pages#admin_panel'
    end
  end

  # Sign in/ Sign out for devise sessions
  as :user do
    get "/admin" => "devise/sessions#new", :as => :new_user_session
    post "/admin" => "devise/sessions#create", :as => :user_session
    delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end

  # Resources
  resources :categories, path: '/blogs/category' do
    get '/page/:page', action: :index, on: :collection
  end

  resources :blogs do
    get '/page/:page', action: :index, on: :collection
  end

  resources :contact_form, only: %i[new create]

  # Pages
  root to: 'pages#home'
  
  get 'contact', to: 'pages#contact', as: 'contact'
  get 'about', to: 'pages#about', as: 'about'
  get 'thanks', to: 'pages#thanks', as: 'thanks'
end