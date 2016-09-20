ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :dashboard_ids => []

  filter :email

  index do
    selectable_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :confirmed_at
    actions
  end

  form do |f|
    f.inputs 'Admin Details' do
      if resource.new_record?
        f.input :email
        f.input :password
        f.input :password_confirmation
      else
        f.input :email, :as => :string, :input_html => {:value => resource.email, :class => '', :disabled => true}
      end
    end

    f.inputs 'Dashboards' do
      f.input :dashboards, :as => :select, :collection => Dashboard.by_name.all, :input_html => {:multiple => true}
    end

    f.actions
  end

end
