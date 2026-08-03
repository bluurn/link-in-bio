class ContentsController < ApplicationController
  def show
    @community = Community.find_by!(slug: params[:slug])
    @content = Content.find_by!(slug: params[:id])
  end
end
