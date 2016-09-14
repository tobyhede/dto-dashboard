Rails.application.routes.draw do
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

  get root 'dashboards#index'

  get '/index.html', :to => redirect('/')

  get '/copyright', :to => 'about#index'

  get '/portal', :to => 'portal#index' unless Rails.env.production?

end
