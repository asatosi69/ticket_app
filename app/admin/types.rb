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

permit_params :kind, :seat, :price, :color_id

index do
    selectable_column
    id_column
    column :kind
    column :seat
    column :price #この行をを追加しました(2019/1/22)
    column Type.human_attribute_name(:color) do |t|
      "<span style= 'color: #{t.color&.color_name}'>#{t.color&.color_name}</span>".html_safe
    end
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
      f.input :color_id, as: :select, collection: Color.pluck(:color_name, :id).to_h #nameを入力必須にしたので、pluck内の『:email』を『:name』に変更しました。(2019/1/22)
    end
    f.actions
  end

show title: :kind do
  attributes_table do
      row :kind
      row :seat
      row :price
      row :color_id do |t|
        t.color.color_name
      end
    end
end

  controller do
    def destroy
      resource = find_resource
      resource.destroy

      if resource.errors.full_messages.blank?
        flash[:notice] = '削除しました。'
      else
        flash[:error] = resource.errors.full_messages
      end
      redirect_to action: :index
    end
  end
end
