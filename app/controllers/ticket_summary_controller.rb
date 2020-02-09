# For Ticket Summary
class TicketSummaryController < ApplicationController
  before_action :authenticate_user!

  # /users/1/ticket_summary.json
  def user_summary
    fail if params[:id].to_i != current_user.id
    @user = User.find(params[:id])
    summary_info =
      if current_user.admin?
        Ticket.calc_summary_for_all
      else
        [Ticket.calc_summary_for_user(current_user)]
      end
    render json: summary_info
  end

  # /ticket_summary_by_payment_method.json
  def payment_summary
    render json: Ticket.calc_summary_for_all_by_payment_method
  end
end
