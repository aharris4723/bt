Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'devise/sessions'
  }
  
  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end

    
    resources :events
    resources :comments
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    resources :posts
    
  end
end
