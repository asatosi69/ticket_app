class LinksController < InheritedResources::Base

  private

    def link_params
      params.require(:link).permit(:type_id, :stage_id)
    end

end
