Rails.application.routes.draw do
  resources :users, only: [] do
    member do
      get :register, to: 'registers#new'
      post :register_confirm, to: 'registers#create'
      patch :register_confirm, to: 'registers#update'
      get 'show_confirm/:register_id', to: 'registers#show_confirm', as: :show_confirm
      get 'edit/:register_id', to: 'registers#edit', as: :edit_register
      patch :register_to_confirm, to: 'registers#to_confirm'
      get :thankyou, to: 'registers#thankyou'
      get :ticket_summary, to: 'ticket_summary#user_summary'
    end
  end
  get :ticket_summary_by_payment_method, to: 'ticket_summary#payment_summary'

  resources :links, only: %i[create destroy]

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad
  get 'welcome/index'
  root to: "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # NOTE: 以下は、存在しないURL(id部分を変更したときのURL直接実行を想定)時のリダイレクト処理
  match ':any', to: 'application#render_404', via: [:get]
  match 'admin/:any', to: 'application#render_404', via: [:get]
end
