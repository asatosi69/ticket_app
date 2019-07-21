# For Ticket Summary
class TicketSummaryController < ApplicationController
  before_action :authenticate_user!
  def user_summary
    @user = User.find(params[:id])
  end
end
