ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :dashboard_ids => [], :dataset_ids => []

  filter :email

  controller do
    private

    def local_qr_path(user)
      "/tmp/dto-dashboard-user-qr-#{user.id}.png"
    end
  end

  member_action :two_factor, method: [:post, :delete] do
    case
    when request.post?
      resource.otp_required_for_login = true
      resource.otp_secret = User.generate_otp_secret
      resource.save!
      issuer = 'DTO Dashboard'
      label = "#{issuer}:#{resource.email}"
      uri = resource.otp_provisioning_uri label, issuer: issuer
      RQRCode::QRCode.new(uri).as_png file: local_qr_path(resource)
      @qr_image_path = qr_image_admin_user_path resource
    when request.delete?
      resource.otp_required_for_login = false
      resource.save!
      redirect_to({ action: :show, id: resource.id },
        notice: 'Removed two-factor authentication')
    end
  end

  member_action :qr_image, method: :get do
    send_file local_qr_path(resource), type: 'image/png', disposition: 'inline'
  end

  action_item :enable_two_factor, only: :show do
    link_to 'Enable 2FA', two_factor_admin_user_path(user), method: :post
  end

  action_item :disable_two_factor, only: :show do
    link_to 'Disable 2FA', two_factor_admin_user_path(user), method: :delete
  end

  index do
    selectable_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :confirmed_at
    column :dashboards do | user |
      user.dashboards.count
    end
    column :datasets do | user |
      user.dashboards.count
    end
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

    f.inputs 'Datatsets' do
      f.input :datasets, :as => :select, :collection => Dataset.by_name.all, :input_html => {:multiple => true}
    end

    f.actions
  end

  show do
    panel 'User' do
      attributes_table_for user do
        row :id
        row :email
      end
    end
    panel 'Dashboards' do
      attributes_table_for user do
        user.dashboards.each do |dashboard|
          row ' ' do
            link_to(dashboard.name, admin_dashboard_path(dashboard))
          end
        end
      end
    end
    panel 'Datasets' do
      attributes_table_for user do
        user.datasets.each do |dataset|
          row ' ' do
            link_to(dataset.name, admin_dataset_path(dataset))
          end
        end
      end
    end
    panel 'Details' do
      attributes_table_for user do
        row :sign_in_count
        row :current_sign_in_at
        row :last_sign_in_at
        row :last_sign_in_ip
        row :confirmed_at
        row :failed_attempts
        row :locked_at
        row :created_at
        row :updated_at
      end
    end
  end

end
