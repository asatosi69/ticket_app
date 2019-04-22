Rails.application.routes.draw do
  resources :users, only: [] do
    member do
      get :register, to: 'registers#new'
      post :register_confirm, to: 'registers#confirm'
      get 'show_confirm/:register_id', to: 'registers#show_confirm', as: :show_confirm
      get 'edit/:register_id', to: 'registers#edit', as: :edit_register
      patch :register_to_confirm, to: 'registers#to_confirm'
      get :thankyou, to: 'registers#thankyou'
    end
  end

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'welcome/index'
  root to: "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
