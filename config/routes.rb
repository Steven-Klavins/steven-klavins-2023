Rails.application.routes.draw do
  root to: 'pages#home'
  get 'contact', to: 'pages#contact', as: 'contact'
  get 'about', to: 'pages#about', as: 'about'
end
