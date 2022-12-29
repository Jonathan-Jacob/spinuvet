module Spina::Admin
  class ParentPagesController < AdminController

    def index
      @resource = Spina::Resource.find_by(id: params[:resource_id])
      @pages = Spina::Page.where(resource: @resource).sorted.includes(:translations).where(deleted: false)
    end

  end
end
