class CommunitiesController < ApplicationController
  def show
    @community = Community.find_by!(slug: params[:slug])
    @selections = @community.selections.includes(:content).order("contents.title")
  end
end
