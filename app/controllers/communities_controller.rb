class CommunitiesController < ApplicationController
  def index
    community = Community.order(:name).first!
    redirect_to community_path(community.slug)
  end

  def show
    @community = Community.find_by!(slug: params[:slug])
    @selections = @community.selections.includes(:content).order("contents.title")
  end
end
