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

permit_params :count, :b_name, :b_mail, :comment, :user_id, :stage_id, :type_id, :comment2, users_attributes: [:name], stages_attributes: [:performance], types_attributes: [:kind]


index do
    selectable_column
    id_column
    column User.human_attribute_name(:name) do |t|
      t.user.name
    end
    column Stage.human_attribute_name(:performance) do |t|
      t.stage.performance
    end
    column Type.human_attribute_name(:kind) do |t|
      t.type.kind
    end
    column :count
    column :b_name
    column :b_mail
    column :comment
    column :comment2 #comment2 を追加しました(2019/1/22)
    actions
  end

    filter :user_name, label: User.human_attribute_name(:name), as: :select, collection: User.pluck(:name)
    filter :stage_performance, label: Stage.human_attribute_name(:performance), as: :select, collection: Stage.pluck(:performance)
    filter :type_kind, label: Type.human_attribute_name(:kind), as: :select, collection: Type.pluck(:kind)
    # filter :count コメント化しました(2019/1/22)
    filter :b_name
    # filter :b_mail コメント化しました(2019/1/22)
    filter :comment2 # comment から comment2 に変更しました(2019/1/22)

  form do |f|
    f.inputs do
      # NOTE: emailをnameに変更することでnameを表示できるが、nameが現状必須項目でない かつ nameがない場合は選択肢に表示できないので、emailを出すようにしています。nameにする場合は、User.nameが必須で入るようにvalidationを入れる必要があります。
      if current_user.admin?
        f.input :user_id, as: :select, collection: User.pluck(:name, :id).to_h #nameを入力必須にしたので、pluck内の『:email』を『:name』に変更しました。(2019/1/22)
      else
        f.input :user_name, input_html: { value: current_user.name, disabled: true }
        f.input :user_id, input_html: { value: current_user.id }, as: :hidden
      end
      if current_user.admin?
        f.input :stage_id, as: :select, collection: Stage.performance_order.pluck(:performance, :id).to_h
      else
        f.input :stage_id, as: :select, collection: Stage.performance_order.on_sale.pluck(:performance, :id).to_h
      end
      f.input :type_id, as: :select, collection: Type.pluck(:kind, :id).to_h
      f.input :count
      f.input :b_name
      f.input :b_mail
      f.input :comment
      f.input :comment2
    end
    f.actions
  end

  controller do
    def create
      @ticket = Ticket.new(permitted_params[:ticket])
      validation_context = current_user.admin? ? :admin : nil

      if @ticket.save(context: validation_context)
        redirect_to admin_ticket_path(@ticket)
      else
        render :new
      end
    end

    def update
      @ticket = find_resource
      @ticket.attributes = permitted_params[:ticket]
      validation_context = current_user.admin? ? :admin : nil

      if @ticket.save(context: validation_context)
        redirect_to admin_ticket_path(@ticket)
      else
        render :edit
      end
    end
  end

  show :title => 'チケット' do
    attributes_table do
      row :user_id do |t|
        t.user.name
      end
      row :stage_id do |t|
        t.stage.performance
      end
      row :type_id do |t|
        t.type.kind
      end
      row :count
      row :b_name
      row :b_mail
      row :comment
      row :comment2
    end
  end
end
