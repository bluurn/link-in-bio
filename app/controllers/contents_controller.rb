class ContentsController < ApplicationController
  def show
    @community = Community.find_by!(slug: params[:slug])
    @content = Content.find(params[:id])
  end
end
