ActiveAdmin.register PaymentMethod do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :name, :discount_rate

  index do
    selectable_column
    id_column
    column :name
    column :discount_rate
    actions
  end

  filter :name
  filter :discount_rate

  form do |f|
    f.inputs do
      f.input :name
      f.input :discount_rate
    end
    f.actions
  end

  show title: :name do
    attributes_table do
      row :name
      row :discount_rate
    end
  end
end
