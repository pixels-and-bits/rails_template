Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :accounts,
    path: '/',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'signup'
    }

  devise_for :admin_accounts,
    path: 'admin',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
    }

  namespace :admin do

    get '/',
      controller: 'base',
      action: 'index'

  end

end
