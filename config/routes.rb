Rails.application.routes.draw do
  root 'companies#search'

  resources :companies, only: [] do
    collection do
      get :search
      get :search_results
    end
  end

  scope :admin do
    resources :companies do
      collection do
        get :upload
        post :import
      end
    end
  end
end
