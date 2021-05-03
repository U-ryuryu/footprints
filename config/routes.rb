Rails.application.routes.draw do
  get 'visit_comments/create'
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:      'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users/:id/edit' => 'users/registrations#edit', as: :edit_user_id_registration
    match 'users/:id', to: 'users/registrations#update', via: [:patch, :put], as: :user_id_registration
    delete 'users/:id' => 'users/registrations#destroy', as: :user_delete_registration
  end
  root to: "clients#index"
  resources :clients do
    resources :visits, except: :index do
      resources :visit_comments, only: :create
    end
    resources :calls, except: :index do
      resources :call_comments, only: :create
    end
  end
end
