# frozen_string_literal: true

class LinksController < ApplicationController
  def create
    Link.new(type_id: params[:type_id], stage_id: params[:stage_id]).save
  end

  def destroy
    Link.find(params[:id]).destroy
  end
end
