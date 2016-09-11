Rails.application.routes.draw do
  resources :dashboards, :only => [:index, :show] do
    member do
      get :export
    end
  end

  get 'feedback', :to => 'feedback#index'

  get root 'dashboards#index'

  get '/index.html', :to => redirect('/')

  get '/copyright', :to => 'about#index'

end
