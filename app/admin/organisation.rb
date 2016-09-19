ActiveAdmin.register Organisation do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs "Organisation" do
      f.input :name, :as => :string
    end
    f.actions
  end

end
