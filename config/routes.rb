Rails.application.routes.draw do
  resources :companies

  resources :email_addresses, except: [:index, :show]

  root to: 'people#index'

  resources :phone_numbers, except: [:index, :show]

  resources :people

end
