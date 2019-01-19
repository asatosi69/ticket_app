ActiveAdmin.register Ticket do
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

permit_params :count, :b_name, :b_mail, :comment, users_attributes: [:name], stages_attributes: [:performance], types_attributes: [:kind]


index do
    selectable_column
    id_column
    column :ticket.user.name
    column :ticket.stage.performance
    column :ticket.type.kind
    column :count
    column :b_name
    column :b_mail
    column :comment
    actions
  end

    filter :user_name, as: :string
    filter :stage_performance, as: :string
    filter :type_kind, as: :string
    filter :count
    filter :b_name
    filter :b_mail
    filter :comment

  form do |f|
    f.inputs do
      f.input :count
      f.input :b_name
      f.input :b_mail
      f.input :comment
      # NOTE: emailをnameに変更することでnameを表示できるが、nameが現状必須項目でない かつ nameがない場合は選択肢に表示できないので、emailを出すようにしています。nameにする場合は、User.nameが必須で入るようにvalidationを入れる必要があります。
      f.input :user_id, as: :select, collection: User.pluck(:email, :id).to_h
      f.input :stage_id, as: :select, collection: Stage.pluck(:performance, :id).to_h
    end
    f.actions
  end
end
