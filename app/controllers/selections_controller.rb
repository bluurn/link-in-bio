class SelectionsController < ApplicationController
  def create
    community = Community.find_by!(slug: params[:slug])
    community.selections.create!(content_id: params[:content_id])
    redirect_to manage_path(community.slug, q: params[:q], kind: params[:kind])
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique
    redirect_to manage_path(params[:slug], q: params[:q], kind: params[:kind])
  end

  def destroy
    community = Community.find_by!(slug: params[:slug])
    community.selections.find(params[:id]).destroy!
    redirect_to manage_path(community.slug, q: params[:q], kind: params[:kind], tab: "1")
  end
end
