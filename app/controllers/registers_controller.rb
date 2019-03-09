class RegistersController < InheritedResources::Base

  private

    def register_params
      params.require(:register).permit(:user_id, :count, :b_name, :b_email, :stage_id, :type_id, :comment, :state, :ticket_id)
    end
end

