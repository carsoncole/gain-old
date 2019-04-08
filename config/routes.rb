Rails.application.routes.draw do
  resources :users

  resources :accounts do
    resources :transactions
  end
end
