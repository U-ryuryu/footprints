class CallCommentsController < ApplicationController
  before_action :redirect_user
  def create
    comment = CallComment.create(comment_params)
    comment.call.touch
    comment.call.client.touch
    redirect_to "/clients/#{comment.call.client_id}/calls/#{comment.call.id}"
  end

  private

  def redirect_user
    redirect_to root_path and return unless user_signed_in?
    redirect_to root_path unless current_user.admin.id == Client.find(params[:client_id]).admin.id
  end

  def comment_params
    params.require(:call_comment).permit(:comment).merge(user_id: current_user.id, call_id: params[:call_id])
  end
end
