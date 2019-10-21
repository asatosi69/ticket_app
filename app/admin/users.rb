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
    @stage_ticket_seats_info = []
    @stages.each do |stage|
      @stage_ticket_seats_info << stage.sumup_ticket_seat_info
    end
    @sum_of_stage_ticket_seats = {}
    @sum_of_stage_ticket_seats[:total_seats_count] =
      @stage_ticket_seats_info.map { |v| v[:total_seats_count] }.inject(:+)
    count_by_type_summary = {}
    @stage_ticket_seats_info.map { |stage_summary| stage_summary[:counts_by_type] }.each do |count_by_types|
      count_by_types.each do |count_by_type|
        type_id = count_by_type[:type_id]
        count_by_type_summary[type_id] ||= {}
        count_by_type_summary[type_id][:color_code] ||= count_by_type[:color_code]
        count_by_type_summary[type_id][:count] ||= 0
        count_by_type_summary[type_id][:count] += count_by_type[:count]
      end
    end
    @sum_of_stage_ticket_seats[:count_by_type_summary] = count_by_type_summary
    render '_show_ticket_summary'
  end
end
