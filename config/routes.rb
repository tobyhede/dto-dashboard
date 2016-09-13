Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  get root :to => 'dashboards#index'

  resources :dashboards, :only => [:index, :show] do
    member do
      get :export
    end
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :datasets do
        resources :datapoints
      end
    end
  end

  get 'feedback', :to => 'feedback#index'

  get '/index.html', :to => redirect('/')

  get '/copyright', :to => 'about#index'

  get '/portal', :to => 'portal#index' unless Rails.env.production?

end
