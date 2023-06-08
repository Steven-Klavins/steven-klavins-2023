Rails.application.routes.draw do
  resources :categories, path: '/blogs/category' do
    get '/page/:page', action: :index, on: :collection
  end

  resources :blogs do
    get '/page/:page', action: :index, on: :collection
  end

  root to: 'pages#home'

  get 'contact', to: 'pages#contact', as: 'contact'
  get 'about', to: 'pages#about', as: 'about'
end