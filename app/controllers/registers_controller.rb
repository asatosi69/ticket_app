class RegistersController < ApplicationController

  def new
    return redirect_to 'https://google.co.jp' if User.where(id: params[:id]).blank?
    @register = Register.new(user_id: params[:id])
  end

  def confirm
    @register = Register.new(register_params)
    @register.user_id = params[:id]
    unless @register.save
      render action: :new
    end
  end

  def to_confirm
    @register = Register.find(params[:register][:register_id])
    if @register.generate_ticket
      render action: :thankyou
    end
  end

  def thankyou
  end

  private

  def register_params
    params.require(:register).permit(:user_id, :count, :b_name, :b_email, :stage_id, :type_id, :comment, :state, :ticket_id)
  end
end

