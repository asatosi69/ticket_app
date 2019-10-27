# frozen_string_literal: true

class LinksController < ApplicationController
  def create
    @link = Link.new(type_id: params[:type_id], stage_id: params[:stage_id])
    @link.save
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
  end
end
