ActiveAdmin.register Type do
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

permit_params :kind, :seat


index do
    selectable_column
    id_column
    column :kind
    column :seat
    actions
  end

  filter :kind
  filter :seat

  form do |f|
    f.inputs do
      f.input :kind
      f.input :seat
    end
    f.actions
  end

end
