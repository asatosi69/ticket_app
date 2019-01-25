ActiveAdmin.register Stage do
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

permit_params :performance, :total

  index do
    selectable_column
    id_column
    column :performance
    column :total
    column :deadline #この行をを追加しました(2019/1/22)
    column :end_flag #この行をを追加しました(2019/1/22)
    actions
  end

  filter :performance
  filter :total
  filter :deadline #この行をを追加しました(2019/1/22)
  filter :end_flag #この行をを追加しました(2019/1/22)

  form do |f|
    f.inputs do
      f.input :performance
      f.input :total
      f.input :deadline #この行をを追加しました(2019/1/22)
      f.input :end_flag #この行をを追加しました(2019/1/22)
    end
    f.actions
  end
  
end
