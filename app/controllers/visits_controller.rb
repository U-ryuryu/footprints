class VisitsController < ApplicationController
  before_action :redirect_user
  before_action :redirect_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_current_user, only: [:edit, :update, :destroy]
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
    @visit = Visit.find(params[:id])
  end

  def edit
  end

  def update
    if @visit.update(visit_params)
      redirect_to client_visit_path
    else
      render :edit
    end
  end

  def destroy
    @visit.delete
    redirect_to client_path(params[:client_id])
  end

  private

  def visit_params
    params.require(:visit).permit(:title, :date, :content, :status_id).merge(user_id: current_user.id, client_id: params[:client_id])
  end

  def redirect_user
    if admin_signed_in?
      redirect_to root_path and return unless current_admin.id == Client.find(params[:client_id]).admin.id
    elsif user_signed_in?
      redirect_to root_path and return unless current_user.admin.id == Client.find(params[:client_id]).admin.id
    else
      redirect_to root_path
    end
  end

  def redirect_admin
    redirect_to root_path and return unless user_signed_in?
  end

  def redirect_current_user
    @visit = Visit.find(params[:id])
    redirect_to root_path if current_user.id != @visit.user_id
  end
end
