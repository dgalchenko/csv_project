Rails.application.routes.draw do
  root 'companies#search'

  resources :companies, only: [] do
    collection do
      get :search
      get :upload
    end
  end
end
