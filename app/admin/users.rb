ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation, :admin

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :admin
    actions
  end

  filter :name
  filter :email
  filter :admin

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :admin
    end
    f.actions
  end

end
