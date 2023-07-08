require 'sidekiq/web'

Rails.application.routes.draw do
  # Resources
  resources :categories, path: '/blogs/category' do
    get '/page/:page', action: :index, on: :collection
  end

  resources :blogs do
    get '/page/:page', action: :index, on: :collection
  end

  resources :contact_form, only: %i[new create]

  # Sidekiq
  mount Sidekiq::Web => "/sidekiq"

  # Pages
  root to: 'pages#home'
  get 'contact', to: 'pages#contact', as: 'contact'
  get 'about', to: 'pages#about', as: 'about'
  get 'thanks', to: 'pages#thanks', as: 'thanks'
end