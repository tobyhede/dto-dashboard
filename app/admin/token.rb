ActiveAdmin.register Token do
  decorate_with TokenDecorator

  actions :all, except: [:destroy]

  permit_params :user_id, :session

  filter :user

  controller do
    def scoped_collection
      super.api.includes(:user)
    end
  end

  index do
    selectable_column
    column :token
    column :user
    column :active? do | token|
      status_tag token.active?
    end
    actions defaults: true do |token|
      link_to('Expire', expire_admin_token_path(token), :method => 'patch')
    end
  end

  form do |f|
    f.inputs 'Token' do
      f.input :session, :as => :hidden, :input_html => { :value => false }

      if resource.new_record?
        f.input :user, :required => true, :as => :select, :collection => User.by_email.all
        f.input :expired_at
      else
        f.input :user, :as => :string, :input_html => {:value => resource.user.email, :class => '', :disabled => true}
        f.input :expired_at, :as => :string, :input_html => {:value => resource.expired_at, :class => '', :disabled => true}
      end

    end

    f.actions
  end

  action_item :expire_token, :only => [:show, :edit], :if => -> { resource.active? }  do
    link_to('Expire Token', expire_admin_token_path(resource), :method => 'put')
  end

  member_action :expire, :method => :put do
    resource.expire! if resource.active?
    redirect_to resource_path, notice: 'Token Expired'
  end

end
