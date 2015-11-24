ActiveAdmin.register User do

  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :email
    column :created_at
    column :sign_in_count
    column :last_sign_in_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Identity" do
      f.input :first_name
      f.input :last_name
      f.input :email
    end
    f.actions
  end

  permit_params :first_name, :last_name, :email

end
