class ManageController < ApplicationController
  def show
    @community = Community.find_by!(slug: params[:slug])
    @q = params[:q].to_s.strip
    @kind = params[:kind].to_s
    @catalog = Content.by_kind(@kind).search(@q).order(:title)
    @selected_ids = @community.selections.pluck(:content_id).to_set
    @selections = @community.selections.includes(:content).order("contents.title")
  end
end
