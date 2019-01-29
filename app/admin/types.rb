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


  

permit_params :kind, :seat, :price


index do
    selectable_column
    id_column
    column :kind
    column :seat
    column :price #この行をを追加しました(2019/1/22)
    actions
  end

  filter :kind
  filter :seat
  filter :price #この行をを追加しました(2019/1/22)


form do |f|
    f.inputs do
      f.input :kind
      f.input :seat
      f.input :price #この行をを追加しました(2019/1/22)
    end
    f.actions
  end
  
  
show title: :kind do  
  attributes_table do
      row :kind
      row :seat
      row :price
    end
end

end
