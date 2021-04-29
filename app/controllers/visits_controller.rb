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

  def edit
    @visit = Visit.find(params[:client_id])
  end

  def update
    @visit = Visit.find(params[:client_id])
    if @visit.update(visit_params)
      redirect_to client_visit_path(@visit.id)
    else
      render :edit
    end
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
