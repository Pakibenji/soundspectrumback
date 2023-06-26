Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'private/user'
  delete '/delete_user', to: 'users/registrations#destroy'
  devise_for :users, 
    path: '', 
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup',
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
    }
    
end