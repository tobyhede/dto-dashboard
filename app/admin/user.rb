ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

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
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
