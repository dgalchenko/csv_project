Rails.application.routes.draw do
  root 'companies#search'

  resources :companies, only: [] do
    collection do
      get :search
      get :search_results
      get :upload
    end
  end
end
