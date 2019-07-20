# For Ticket Summary
class TicketSummaryController < ApplicationController
  before_action :authenticate_user!
  def list
    @user = User.find(params[:id])
  end
end
