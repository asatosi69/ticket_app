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
  collection_action :show_ticket_summary, method: :get do
    @page_title = "『#{current_user.name}』チケット集計データ"
    @stages = Stage.performance_order
    @ticket_summary_for_all = Ticket.calc_summary_for_all
    @sum_of_stage_total = @stages.pluck(:total).sum
    @stage_ticket_seats = []
    @stages.each do |stage|
      @stage_ticket_seats << stage.sumup_ticket_seat
    end
    @sum_of_stage_ticket_seats = @stage_ticket_seats.inject(:+)
    render '_show_ticket_summary'
  end
end
