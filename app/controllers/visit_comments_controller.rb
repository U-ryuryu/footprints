class VisitCommentsController < ApplicationController
  before_action :redirect_user
  def create
    comment = VisitComment.create(comment_params)
    comment.visit.touch
    comment.visit.client.touch
    redirect_to "/clients/#{comment.visit.client_id}/visits/#{comment.visit.id}"
  end

  private

  def redirect_user
    redirect_to root_path and return unless user_signed_in?
    redirect_to root_path unless current_user.admin.id == Client.find(params[:client_id]).admin.id
  end

  def comment_params
    params.require(:visit_comment).permit(:comment).merge(user_id: current_user.id, visit_id: params[:visit_id])
  end
end
