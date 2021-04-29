class VisitsController < ApplicationController
  before_action :redirect_user, only: [:new,:create]
  def new
    @visit = Visit.new
  end

  def create
    @visit = Visit.new(visit_params)
    if @visit.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @visit = Visit.find(params[:client_id])
  end

  private

  def visit_params
    params.require(:visit).permit(:title, :date, :content, :status_id).merge(user_id: current_user.id, client_id: params[:client_id])
  end

  def redirect_user
    redirect_to root_path and return unless user_signed_in?
    if current_user.admin.id != Client.find(params[:client_id]).admin.id
      redirect_to  root_path
    end
  end
end
