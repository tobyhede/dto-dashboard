ActiveAdmin.register Dashboard do
  permit_params :name, :url, :notes, :display_hero, :display_kpis, :published_at

  index do
    selectable_column
    column :name
    column :organisation
    actions
  end

  filter :name
  filter :organisation

  form do |f|
    f.inputs "Dashboard" do
      f.input :name, :as => :string
      f.input :url, :as => :string
      f.input :description, :label => 'What is the service?'
      f.input :target_users, :label => 'Who is the user group?'
      f.input :notes
      f.input :display_hero
      f.input :display_kpis
      f.input :published_at
    end
    f.actions
  end

end
