class RegistersController < ApplicationController
  before_action :set_register, only: %i(update)

  def new
    return redirect_to 'https://google.co.jp' if User.where(id: params[:id]).blank?
    @register = Register.new(user_id: params[:id])
  end

  def edit
    @register = Register.init.find(params[:register_id]) # NOTE: 修正可能なのは、initの状態のもののみ
  end

  def create
    @register = Register.new(register_params)
    @register.user_id = params[:id]
    if @register.save
      redirect_to show_confirm_user_path(id: @register.user_id, register_id: @register.id)
    else
      render action: :new
    end
  end

  def update
    if @register.update(register_params)
      redirect_to show_confirm_user_path(id: @register.user_id, register_id: @register.id)
    else
      render action: :new
    end
  end

  def show_confirm
    @register = Register.find_by(user_id: params[:id], id: params[:register_id])
  end

  def to_confirm
    @register = Register.find(params[:register][:register_id])
    if @register.valid? && @register.generate_ticket
      redirect_to thankyou_user_path(@register.user.id) and return
    else
      render action: :edit
    end
  end

  def thankyou
  end

  private

  def set_register
    @register = Register.find_by(
      id: params[:register][:id],
      user_id: params[:register][:user_id]
    )
  end

  def register_params
    params.require(:register).permit(:user_id, :count, :b_name, :furigana, :b_email, :stage_id, :type_id, :comment, :state, :ticket_id)
  end
end

